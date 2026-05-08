Return-Path: <stable+bounces-244696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBhIAb+a/WkJgQAAu9opvQ
	(envelope-from <stable+bounces-244696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:11:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3624F38AC
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BB2A3037DE2
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91E37B025;
	Fri,  8 May 2026 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="PFIgrnXf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07602D97A6
	for <stable@vger.kernel.org>; Fri,  8 May 2026 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227644; cv=none; b=K8zTQXckzhF9dMvSy6tVijNQM66EG8QHkRAx7lMEuwGJEH+MiS7cLFPaOcU3UTehFx7k2vJT+gq6+4TCYzj5OX88ya7wLjhZJkXEyhxeT62K9ZlGVrcWGPwalK/XcPTRU8K4T5MeqSh3c4s/HzxhHYEOLiq9Degiy6X11TnX28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227644; c=relaxed/simple;
	bh=c3xHH694o+zphEIQVN9RVAb0WxSsn7choMJU73Az8Kg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MQQkXjo95kI1ksSc1zQBxckGWC8P1SuN+4KhAGHDdEZd5vj/XSW9EdtzsfeW04y4msmdioK5rTBrAdDs+YRZNZsmsAO0arIrY38Xkj58zOEmgUNTxdQaR8BnApjSXi3S0JhH38BKRDzF7wC6u++ADyB7PXcvk3teSRIx/P1BPOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=PFIgrnXf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso16583445ad.2
        for <stable@vger.kernel.org>; Fri, 08 May 2026 01:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1778227641; x=1778832441; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE9SvXJ/p2OOR2/6OIE6c5VL6XNI0jB0FPluXe8xKDk=;
        b=PFIgrnXf5Ycfg2oS+WJ9m4E3KWJGPsAiOvDSP+O/kwJ66X0mdkmCVeuL9iNtnZfpvv
         BUJTndeZ2tNLqeNlTjEmtfT4VTbqEfVirQ2PIFZ2KNv+jPgWPalBzESCELrJkzdl4eIL
         cctjwnlcenMM8ZUM/hSi6eopsr59Vs5Kw/U9LRajr4aSHt7ALEtNSjB0RmMajYiGV000
         00j0gMRRPCgugoSh2GP5RMW+CYqF4u2w1EduJmb08nB6ebeUgo5MMTb3P2jOGReHTCeC
         Dy+27BWOp3E5i+Z4yIGn6AoiTkS1R7a7xZwCpF99zoTxGNs6nUtjwbIPTTmHYMZt42Jq
         37HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778227641; x=1778832441;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NE9SvXJ/p2OOR2/6OIE6c5VL6XNI0jB0FPluXe8xKDk=;
        b=WTp39lWeMNXp+j5SsQKCIPuAaMbm95oZooZS+eacwXbht960rQFGjwGZIuAZ9Lhzvv
         yEO3XzI8Cv6XFLOaO+VO7ksMBwzZuv8T7b9xZ0FukQKLB3vVblkrgiHouMG6leNq2Fh2
         Hef74orOhkIExjoSuvOclv4nG1CIOirwvN6YH1mrg9H1QymJJdwpObVuuzkq01wP9fOw
         A4UEikOPhSpFvMz6e14VHODhtgByI32DzJ96HbLiLrpCOlkW8SkAINakn0JQ3l2nZcgC
         qC8KVZ7RBt2mKSUzkZ0W+RMcWev2T+nCAPt+FiUwPLvVmf72xKkZUviFNbNXs1i3IO1W
         LMXw==
X-Forwarded-Encrypted: i=1; AFNElJ8ocf5VyUSUQTrrQJRaq531vnkRNljErKP4f/bZQWPbJBy/nNRM0YfhLyrLAsbN8KRGpTN2wzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYihwRow7R8H0LyU9b5x/jO+kwV7hjyJrg3RPulM+fRMEaxeM
	Dfj/uiGusjtlNm3ihI+vgQ4kPel8GLAm5TvJk86YKXVA6qBvyTodqqTPeyffMKkVyV0=
X-Gm-Gg: Acq92OFf/u6W0g90XGU3hjAJ+oAbnLg3SAaxOFtYWcZ6UyZpT/iFh9zdcleVCXoHyN/
	IjkDAlXLPEHOTaNuXJTfqnmdk/3kTSSxOk5w3viIV6cd1RZ8JXMVoZsmcp2OdhbfXw7KIio2IAD
	5wpLtqNHwRgcrYYNLnJ50Y/UOoB9tHKAbDVw5gOtMyuT91a64CNpvtMz9XKjtY3jRqWr8Y9Dmcp
	oqtZHM1JMjdTpP909w7SpmlMP3s+mH53SstgS8iSoJ2obOl4mIzJ9qoaUUj/dIaJNLMNVqT8RMS
	x0gOBKnwDplSO6mgq5bVqZlzGQNhzntAC3lhUqleqj8QtHlzbk9ZVYlA3J2RmuHv+jn5LBj+qMJ
	nvs7DkvdXoG+hBLJa7gmQhOquEH3p2pSx/gdhstFt8b8YNMT4mW4bGk5WJuBrMgXR57zU+UNS+h
	PlRw3SacQKIoNjejo9u/G/V+4rHPw4PChNUaNuLB8z+M7dCCXHN1iwOe062dpZmzTT24Zw+VYJ1
	7vR8Q==
X-Received: by 2002:a17:903:3887:b0:2ba:83f8:7b7b with SMTP id d9443c01a7336-2ba83f87cfcmr106624425ad.33.1778227640861;
        Fri, 08 May 2026 01:07:20 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e72668sm13300185ad.58.2026.05.08.01.07.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2026 01:07:20 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH 6.6.y] ext4: validate p_idx bounds in
 ext4_ext_correct_indexes
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260508065845.3031006-1-jianqkang@sina.cn>
Date: Fri, 8 May 2026 02:07:08 -0600
Cc: gregkh@linuxfoundation.org,
 stable@vger.kernel.org,
 tejas.bharambe@outlook.com,
 patches@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 tytso@mit.edu,
 linux-ext4@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C2F44AA-6D22-4AB1-9653-68DDDAFB3E06@dilger.ca>
References: <20260508065845.3031006-1-jianqkang@sina.cn>
To: Jianqiang kang <jianqkang@sina.cn>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Queue-Id: 5B3624F38AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244696-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,outlook.com,lists.linux.dev,mit.edu];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	DKIM_TRACE(0.00)[dilger-ca.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[sina.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dilger.ca:mid,sina.cn:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Action: no action

On May 8, 2026, at 00:58, Jianqiang kang <jianqkang@sina.cn> wrote:
>=20
> From: Tejas Bharambe <tejas.bharambe@outlook.com>
>=20
> [ Upstream commit 2acb5c12ebd860f30e4faf67e6cc8c44ddfe5fe8 ]
>=20
> ext4_ext_correct_indexes() walks up the extent tree correcting
> index entries when the first extent in a leaf is modified. Before
> accessing path[k].p_idx->ei_block, there is no validation that
> p_idx falls within the valid range of index entries for that
> level.
>=20
> If the on-disk extent header contains a corrupted or crafted
> eh_entries value, p_idx can point past the end of the allocated
> buffer, causing a slab-out-of-bounds read.
>=20
> Fix this by validating path[k].p_idx against EXT_LAST_INDEX() at
> both access sites: before the while loop and inside it. Return
> -EFSCORRUPTED if the index pointer is out of range, consistent
> with how other bounds violations are handled in the ext4 extent
> tree code.

Thank you for your patch.

Do you have an image with this corruption in place?  Does e2fsck fix
the issue? If not, then ext4 will abort the filesystem when this issue
is hit, and if e2fsck can't fix it then it will just be hit again.

Cheers, Andreas

> Reported-by: syzbot+04c4e65cab786a2e5b7e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D04c4e65cab786a2e5b7e
> Signed-off-by: Tejas Bharambe <tejas.bharambe@outlook.com>
> Link: =
https://patch.msgid.link/JH0PR06MB66326016F9B6AD24097D232B897CA@JH0PR06MB6=
632.apcprd06.prod.outlook.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: stable@kernel.org
> [ Minor conflict resolved. ]
> Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
> ---
> fs/ext4/extents.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>=20
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 7626cf2b07f1..a94798e23c1a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1743,6 +1743,13 @@ static int ext4_ext_correct_indexes(handle_t =
*handle,
>  	err =3D ext4_ext_get_access(handle, inode, path + k);
>  	if (err)
>  	return err;
> +	if (unlikely(path[k].p_idx > EXT_LAST_INDEX(path[k].p_hdr))) {
> +		EXT4_ERROR_INODE(inode,
> +				 "path[%d].p_idx %p > EXT_LAST_INDEX =
%p",
> +				 k, path[k].p_idx,
> +				 EXT_LAST_INDEX(path[k].p_hdr));
> +		return -EFSCORRUPTED;
> +	}
>  	path[k].p_idx->ei_block =3D border;
>  	err =3D ext4_ext_dirty(handle, inode, path + k);
>  	if (err)
> @@ -1755,6 +1762,14 @@ static int ext4_ext_correct_indexes(handle_t =
*handle,
>  		err =3D ext4_ext_get_access(handle, inode, path + k);
>  		if (err)
>  			break;
> +		if (unlikely(path[k].p_idx > =
EXT_LAST_INDEX(path[k].p_hdr))) {
> +			EXT4_ERROR_INODE(inode,
> +					 "path[%d].p_idx %p > =
EXT_LAST_INDEX %p",
> +					 k, path[k].p_idx,
> +					 EXT_LAST_INDEX(path[k].p_hdr));
> +			err =3D -EFSCORRUPTED;
> +			break;
> +		}
>  		path[k].p_idx->ei_block =3D border;
>  		err =3D ext4_ext_dirty(handle, inode, path + k);
>  		if (err)
> --=20
> 2.34.1
>=20


Cheers, Andreas






