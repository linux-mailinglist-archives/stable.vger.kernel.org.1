Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9410F783F3A
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjHVLgA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 07:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjHVLgA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 07:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA18CDF
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 04:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F132C6534C
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 11:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B84C433C7;
        Tue, 22 Aug 2023 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704090;
        bh=AFhESAqTz0CMs4lcJXRWdOt21yDBlMz5CzPIDyJCcCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjeKp5/rasrMypinMup9Yj6Awec5m81ZCymt1X5dfNos23fvaeLrLgzdN8PLi6+bA
         KGpZyT9i2ftARKLDiUhw4iS3DSlQW+pQMxqP6uV/NWPERejQF3RfybRytpxlhC2GaQ
         SSwSoHLIuEZOABJyCZqEz/0Nmz4da1r7raDiYKK3oFmS/njnBIrD8OanGsDbP6LXiZ
         DUxN1BMLcROqRW1UStL1z1LB2u3uzPg1UAo/dVR5/EoA0llKv9ce04BacQPtG8aTVP
         AUfkSvCbZV7rN1Aw9gBBTAetT5ocLAX4hMNJWWfwL8zYaLBtFRFg2hZkJ8De21aSki
         eIXYPdfLoQswg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 14:34:47 +0300
Message-Id: <CUZ1IQQ9H5L9.EQRK4RPNQYC4@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Eric Biggers" <ebiggers@kernel.org>, <fsverity@lists.linux.dev>
Cc:     "Victor Hsieh" <victorhsieh@google.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] fsverity: skip PKCS#7 parser when keyring is empty
X-Mailer: aerc 0.14.0
References: <20230820173237.2579-1-ebiggers@kernel.org>
In-Reply-To: <20230820173237.2579-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun Aug 20, 2023 at 8:32 PM EEST, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> If an fsverity builtin signature is given for a file but the
> ".fs-verity" keyring is empty, there's no real reason to run the PKCS#7
> parser.  Skip this to avoid the PKCS#7 attack surface when builtin
> signature support is configured into the kernel but is not being used.
>
> This is a hardening improvement, not a fix per se, but I've added
> Fixes and Cc stable to get it out to more users.
>
> Fixes: 432434c9f8e1 ("fs-verity: support builtin file signatures")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>
> v3: improve the error message slightly
> v2: check keyring and return early before allocating formatted digest
>
>  fs/verity/signature.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/fs/verity/signature.c b/fs/verity/signature.c
> index b95acae64eac6..90c07573dd77b 100644
> --- a/fs/verity/signature.c
> +++ b/fs/verity/signature.c
> @@ -55,20 +55,36 @@ int fsverity_verify_signature(const struct fsverity_i=
nfo *vi,
> =20
>  	if (sig_size =3D=3D 0) {
>  		if (fsverity_require_signatures) {
>  			fsverity_err(inode,
>  				     "require_signatures=3D1, rejecting unsigned file!");
>  			return -EPERM;
>  		}
>  		return 0;
>  	}
> =20
> +	if (fsverity_keyring->keys.nr_leaves_on_tree =3D=3D 0) {
> +		/*
> +		 * The ".fs-verity" keyring is empty, due to builtin signatures
> +		 * being supported by the kernel but not actually being used.
> +		 * In this case, verify_pkcs7_signature() would always return an
> +		 * error, usually ENOKEY.  It could also be EBADMSG if the
> +		 * PKCS#7 is malformed, but that isn't very important to
> +		 * distinguish.  So, just skip to ENOKEY to avoid the attack
> +		 * surface of the PKCS#7 parser, which would otherwise be
> +		 * reachable by any task able to execute FS_IOC_ENABLE_VERITY.
> +		 */
> +		fsverity_err(inode,
> +			     "fs-verity keyring is empty, rejecting signed file!");
> +		return -ENOKEY;
> +	}
> +
>  	d =3D kzalloc(sizeof(*d) + hash_alg->digest_size, GFP_KERNEL);
>  	if (!d)
>  		return -ENOMEM;
>  	memcpy(d->magic, "FSVerity", 8);
>  	d->digest_algorithm =3D cpu_to_le16(hash_alg - fsverity_hash_algs);
>  	d->digest_size =3D cpu_to_le16(hash_alg->digest_size);
>  	memcpy(d->digest, vi->file_digest, hash_alg->digest_size);
> =20
>  	err =3D verify_pkcs7_signature(d, sizeof(*d) + hash_alg->digest_size,
>  				     signature, sig_size, fsverity_keyring,
>
> base-commit: 456ae5fe9b448f44ebe98b391a3bae9c75df465e
> --=20
> 2.41.0

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
