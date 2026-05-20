Return-Path: <stable+bounces-250023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AmZEOThDWop4gUAu9opvQ
	(envelope-from <stable+bounces-250023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:31:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DFB592085
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DD413387EDE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D53317160;
	Wed, 20 May 2026 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamax.eu header.i=@arkamax.eu header.b="MovymO1O"
X-Original-To: stable@vger.kernel.org
Received: from arkamax.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2D332ECB;
	Wed, 20 May 2026 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292972; cv=none; b=HMrjzPXTDaJXYIBucYeHtJbm75gXsRaidaSSBpKQ0pmkkA0+ag+er+w2FqIgoGD6aop/tBvlVzkrRG0ExX3DVgQgA6/U9NXdmgv9wXM0ZunaTVcgk2T2fDGSmdcsNIQRk2JiXLZaPxDnig+xWzv/1CYCg5N/O0Ol99ZmDQ2X8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292972; c=relaxed/simple;
	bh=GaBbEc9uW+LfiXI2M88y+C80PeLZt/HAXzvHd5Boy+U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=c5NsLbe9/F7rWNthnneH6zjb9H48umjoR0aINWUfaSInncvXNHPdHRNwjIXo64VUJAJ8sia4w9LZOvACzGTp1Q4U56t6SvTM1DICosRzm6KJRU5WneUEehGMZ3mRsGW4FUFd48hH1tudq6waKWKlHjtDQeIiI5z6pUFMgdv1a9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arkamax.eu; spf=pass smtp.mailfrom=arkamax.eu; dkim=pass (2048-bit key) header.d=arkamax.eu header.i=@arkamax.eu header.b=MovymO1O; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamax.eu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=GaBbEc9uW+LfiX
	I2M88y+C80PeLZt/HAXzvHd5Boy+U=; h=in-reply-to:references:subject:cc:
	to:from:date; d=arkamax.eu; b=MovymO1ObrkaEcz6X3fGcxgsmOwsOW6UUc5gIop2
	vcLpL4oNkQckWErXCbkw0iak04CIAb6Ldl7N2TyfnmZMHglBYLRig9qQk8Pu0PWr7IkE65
	ApewtpU8kVHxwUnVSlQbdGH7aPW7sP8/j3qMbpemy9/I9h4xjFvvk5t8FfzCglnhCH6diR
	+CRzjotYHGd6m29+k8sHwJ3yk4jdXszutDS2OVb6Z1uqtprFH9GzZaQxaWk+UXU+IkKt0f
	Np4B4XPJchbbmKS/H+Mnl41w4fFddeI3x3XqQRUv3ezGhmpf2r5JNho5DZgPlwMZjmyAk0
	aPaNw07ExBoK0gWz0dkq2A==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 5e3afc91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 May 2026 17:56:06 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 17:56:05 +0200
Message-Id: <DINMKOIB4PRJ.1Y571RHF6NAQJ@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Alexandru Hossu" <hossu.alexandru@gmail.com>,
 <martin.petersen@oracle.com>
Cc: <bvanassche@acm.org>, <target-devel@vger.kernel.org>,
 <linux-scsi@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: target: iscsi: validate CHAP_R length before
 base64 decode
X-Mailer: aerc 0.21.0
References: <20260518121811.385350-1-hossu.alexandru@gmail.com>
 <20260518235040.48647-1-hossu.alexandru@gmail.com>
In-Reply-To: <20260518235040.48647-1-hossu.alexandru@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arkamax.eu,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arkamax.eu:s=mail1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250023-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlombard@arkamax.eu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arkamax.eu:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 98DFB592085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 1:50 AM CEST, Alexandru Hossu wrote:
> chap_server_compute_hash() allocates client_digest as
> kzalloc(chap->digest_size) and then, for BASE64-encoded responses,
> passes chap_r directly to chap_base64_decode() without checking whether
> the input length could produce more than digest_size bytes of output.
>
> chap_base64_decode() writes to the destination unconditionally as long
> as there is input to consume. With MAX_RESPONSE_LENGTH set to 128 and
> the "0b" prefix stripped by extract_param(), up to 127 base64 characters
> can reach the decoder. 127 characters decode to 95 bytes. For SHA-256
> (digest_size=3D32) this overflows client_digest by 63 bytes; for MD5
> (digest_size=3D16) the overflow is 79 bytes.
>
> The length check at line 344 fires after the write has already happened.
>
> The HEX branch in the same switch statement already validates the length
> up front. Apply the same approach to the BASE64 branch: reject any input
> whose maximum decoded length exceeds digest_size before calling the
> decoder.
>
> DIV_ROUND_UP(digest_size * 4, 3) is the maximum number of base64
> characters that can decode to exactly digest_size bytes, matching the
> convention used in base64.h BASE64_CHARS().
>
> Fixes: 1e5733883421 ("scsi: target: iscsi: Support base64 in CHAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> ---
> v2: use DIV_ROUND_UP(digest_size * 4, 3) as suggested by David Disseldorp
>
>  drivers/target/iscsi/iscsi_target_auth.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/is=
csi/iscsi_target_auth.c
> index c46c69a..50eeded 100644
> --- a/drivers/target/iscsi/iscsi_target_auth.c
> +++ b/drivers/target/iscsi/iscsi_target_auth.c
> @@ -341,6 +341,10 @@ static int chap_server_compute_hash(
>  		}
>  		break;
>  	case BASE64:
> +		if (strlen(chap_r) > DIV_ROUND_UP(chap->digest_size * 4, 3)) {
> +			pr_err("Malformed CHAP_R: base64 payload too long\n");
> +			goto out;
> +		}


There is something that doesn't totally convince me about this length check=
.
Couldn't chap_r contain those Base64 padding '=3D' characters that
would make strlen(chap_r) too big to pass this check?

Maurizio


