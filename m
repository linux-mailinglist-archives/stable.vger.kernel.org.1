Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4E7F4173
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 10:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjKVJTB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 04:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjKVJSs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 04:18:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30912D6F;
        Wed, 22 Nov 2023 01:18:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A7B6B21904;
        Wed, 22 Nov 2023 09:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700644697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiaCWu6M5Ny8VB31ACB+zfudr+a6ts/Ir0FirRERD6s=;
        b=oQB5dNGl/NkLVwyZokXfuuaD/tgRPRiiaL8WSMMAwnLdHazGLSJ6R6Jo6ZHXH5/tooE2aC
        rtxaSV0TjTerMyx7gRau551qxiRS9S7D0Q8jbGvU6atsszntxfj+XC8CZOyJZj4fziB+CD
        FZGovDpG/BNgSTCn+Uihwf/RB8TAgqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700644697;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiaCWu6M5Ny8VB31ACB+zfudr+a6ts/Ir0FirRERD6s=;
        b=FcH5BjGI/v+e0pmCZmoXTGabmVIYFgWep7pGGd43P5kMz2S3X3pbj931xNWFKL+F8Y8zYD
        EKeLyCLThTNW5vDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9029B139FD;
        Wed, 22 Nov 2023 09:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4ewwI1nHXWXEcAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 22 Nov 2023 09:18:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 15349A07DC; Wed, 22 Nov 2023 10:18:17 +0100 (CET)
Date:   Wed, 22 Nov 2023 10:18:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] ext2: Fix ki_pos update for DIO buffered-io fallback
 case
Message-ID: <20231122091817.ktp5kojucsnhs3dd@quack3>
References: <d595bee9f2475ed0e8a2e7fb94f7afc2c6ffc36a.1700643443.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d595bee9f2475ed0e8a2e7fb94f7afc2c6ffc36a.1700643443.git.ritesh.list@gmail.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.28
X-Spamd-Result: default: False [-2.28 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-2.98)[99.91%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed 22-11-23 14:32:15, Ritesh Harjani (IBM) wrote:
> Commit "filemap: update ki_pos in generic_perform_write", made updating
> of ki_pos into common code in generic_perform_write() function.
> This also causes generic/091 to fail.
> This happened due to an in-flight collision with:
> fb5de4358e1a ("ext2: Move direct-io to use iomap"). I have chosen fixes tag
> based on which commit got landed later to upstream kernel.
> 
> Fixes: 182c25e9c157 ("filemap: update ki_pos in generic_perform_write")
> Cc: stable@vger.kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks! I've applied the patch to my tree and will push it to Linus soon.

								Honza

> ---
>  fs/ext2/file.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
> index 1039e5bf90af..4ddc36f4dbd4 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -258,7 +258,6 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			goto out_unlock;
>  		}
>  
> -		iocb->ki_pos += status;
>  		ret += status;
>  		endbyte = pos + status - 1;
>  		ret2 = filemap_write_and_wait_range(inode->i_mapping, pos,
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
