Return-Path: <stable+bounces-250638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ2BGofxDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-250638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:38:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E00594282
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71F8F303CAA1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D902A36D9EA;
	Wed, 20 May 2026 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bkzGvkgq"
X-Original-To: stable@vger.kernel.org
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72171369D6E
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295935; cv=none; b=cQ12JYbMziGUyEpVuuaDf/d1GR/6/f+lfDhyK+n+U1Wa/FiLAitSfo0Q4+oejo+VUmloVw6VehAQuVb/ErSHaHjWDRbjr6OrTiLC75vXUFFrDZDgdLouO9BEqLnwVs4YM6WHujlu3wuEeowmQGUBM7BZbc1EOB4FTZ/hD5ygKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295935; c=relaxed/simple;
	bh=+Rr0ISzy0ssrmZl04gRbEuVRjYfX8LKr4q0WEoB66Dg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tF1p8ANnt5EZSsV05aeiUSFcr8PHlVqDlQFHQ8+XLMz8j/faz/bhK+vmBFWZkwbREiRLurr3jAogJARi02oYuC/vCKs7gG/+SHU8XzBL/7/CsQh2Ew/OrrD1wCzzQqHLu8yTBntrlXaIEmQyZkiVOBQ/AxIZ+mU/Y0VLvN6BTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bkzGvkgq; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779295923; x=1779555123;
	bh=P9sCHsSL31H/tsSPytPmPu0bk1prX7Ymi40wZ1txJcU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bkzGvkgqNyUM1mMJZkvLp5HnQqwhqEJcGyV2dRqWceRljkJKjt5TMcH4xm3SrACaP
	 5lWCfjZdYeZAWAYbrYWPrclmOv2TXitc+hiG2m1pHOqi/dJKP6INtWhBHI7QTwPPzC
	 q3EsN1w5pE/kMG2nEvVi0rIMYQsHpDNh78ggpOHZ/eMG/T5m7TQ2HuMEl3Z8XnnML8
	 EYTsIZZqeiCPHZl1d42I2tVh0neVEvzyHs8eZNxc+DmtGOc+Jg5B/E7sBAzM1dY/8D
	 3KGHWTglyTTbttEIQ28mtzS3TL3O42poAOzrLRcehZMSXcWWgpU70yHy0UQvKr1OsB
	 wpEsmmuYlXw+g==
Date: Wed, 20 May 2026 16:51:57 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
From: Tj <tj.iam.tj@proton.me>
Cc: patches@lists.linux.dev, Chen Cheng <chencheng@fnnas.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Yu Kuai <yukuai@fnnas.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.0 0002/1146] md: suppress spurious superblock update error message for dm-raid
Message-ID: <e08a970e-777d-49af-9981-6dde0ced4738@proton.me>
In-Reply-To: <20260520162148.451131860@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org> <20260520162148.451131860@linuxfoundation.org>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 171538a3e7a1fb733f50972d0ad093ebcbee26f2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250638-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[proton.me:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj.iam.tj@proton.me,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fnnas.com:email,proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: 72E00594282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested on v7.0.9 - looks good:

$ journalctl --dmesg --grep md/raid1
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors
May 20 16:48:56 sunny kernel: md/raid1:mdX: active with 2 out of 2 mirrors

Tested-by: Tj <tj.iam.tj@proton.me>

On 20/05/2026 16:04, Greg Kroah-Hartman wrote:
> 7.0-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Chen Cheng <chencheng@fnnas.com>
>
> [ Upstream commit eff0d74c6c8fd358bc9474c05002e51fa5aa56ad ]
>
> dm-raid has external metadata management (mddev->external =3D 1) and
> no persistent superblock (mddev->persistent =3D 0). For these arrays,
> there's no superblock to update, so the error message is spurious.
>
> The error appears as:
> md_update_sb: can't update sb for read-only array md0
>
> Fixes: 8c9e376b9d1a ("md: warn about updating super block failure")
> Reported-by: Tj <tj.iam.tj@proton.me>
> Closes: https://lore.kernel.org/all/20260128082430.96788-1-tj.iam.tj@prot=
on.me/
> Signed-off-by: Chen Cheng <chencheng@fnnas.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/linux-raid/20260210133847.269986-1-chenchen=
g@fnnas.com
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/md/md.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 3ce6f9e9d38e6..c2cc2302d727d 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2788,7 +2788,9 @@ void md_update_sb(struct mddev *mddev, int force_ch=
ange)
>   =09if (!md_is_rdwr(mddev)) {
>   =09=09if (force_change)
>   =09=09=09set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
> -=09=09pr_err("%s: can't update sb for read-only array %s\n", __func__, m=
dname(mddev));
> +=09=09if (!mddev_is_dm(mddev))
> +=09=09=09pr_err_ratelimited("%s: can't update sb for read-only array %s\=
n",
> +=09=09=09=09=09   __func__, mdname(mddev));
>   =09=09return;
>   =09}
>
> --
> 2.53.0
>
>
>



