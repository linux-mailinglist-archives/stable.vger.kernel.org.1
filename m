Return-Path: <stable+bounces-158357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6898FAE61AF
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 12:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163913B14B3
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E2E280004;
	Tue, 24 Jun 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe3QzChP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1327FB31;
	Tue, 24 Jun 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759244; cv=none; b=Ih4+eksFSzBxoxzEM0rgNfRUib+Kt0/XeryAGRCgFpfLtQudS6fv8Ex+Rgh9GVxZYm/+sp7+MFkPDmjPHEWjJ9dH/LK2eJ2sJVM5lCVABltPna1oPPpwsCC9aC41FD0pBPdm4D+CcygjxXejnSdKuKP3omLkFvs46w/WR4RZq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759244; c=relaxed/simple;
	bh=BqpHavQ/lw1T1YQNn8lbODhWv9axsKn/Q1NKE5nNQW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OduQNNrc7j2R84QYqZIdbv0GlzJOzwTkEctjxYPEoj0AcAQI1eD+nVH4GSWYSmpsENAtjGWUEsQXOTq+sS7lHDB67FNCT8I0VY53GOXn44Km5lq81HlTDVdZZxF8p7QLQ9B84AwOcmvYQCiSj2xGThiOp6id+eAQdtdsgA6Eka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe3QzChP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A916C4CEE3;
	Tue, 24 Jun 2025 10:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750759243;
	bh=BqpHavQ/lw1T1YQNn8lbODhWv9axsKn/Q1NKE5nNQW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fe3QzChPa0+w5DS3WDMm74d1nZ369WNmw5CsWx7cro2n7JB28Ay5n5AFg+TAV1Z0N
	 bwksq4op1CDur52yktBYVmQVk7g9QY9dMm1Zdi/HJQ0lyDc0o3Nk4dkPtqzCInNoP6
	 e4O1UNNvEjioFAZj3FgmsyLDSSRce9eXplanLAqRQ9e95xK55TstVJUnY0sX/sd6eR
	 3qsJ0WhI7RwAO1IsLHGgtfRea6Z0YNqS2ErV3EbfQlJ89Qp8I0fn9AwdvWgcN3FSie
	 rOKnd2+jihZlV5tlSivRrt4zjSVSRse03XDcSGyFPb69U6PCyrAnLWN1gvK63aZHRS
	 ITnnm63uArKCw==
Date: Tue, 24 Jun 2025 11:00:39 +0100
From: Lee Jones <lee@kernel.org>
To: Chao Yu <chao@kernel.org>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [STABLE 5.15+] f2fs: sysfs: add encoding_flags entry
Message-ID: <20250624100039.GA3680448@google.com>
References: <20250416054805.1416834-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416054805.1416834-1-chao@kernel.org>

On Wed, 16 Apr 2025, Chao Yu wrote:

> This patch adds a new sysfs entry /sys/fs/f2fs/<disk>/encoding_flags,
> it is a read-only entry to show the value of sb.s_encoding_flags, the
> value is hexadecimal.
> 
> ===========================      ==========
> Flag_Name                        Flag_Value
> ===========================      ==========
> SB_ENC_STRICT_MODE_FL            0x00000001
> SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
> ===========================      ==========
> 
> case#1
> mkfs.f2fs -f -O casefold -C utf8:strict /dev/vda
> mount /dev/vda /mnt/f2fs
> cat /sys/fs/f2fs/vda/encoding_flags
> 1
> 
> case#2
> mkfs.f2fs -f -O casefold -C utf8 /dev/vda
> fsck.f2fs --nolinear-lookup=1 /dev/vda
> mount /dev/vda /mnt/f2fs
> cat /sys/fs/f2fs/vda/encoding_flags
> 2
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 13 +++++++++++++
>  fs/f2fs/sysfs.c                         |  9 +++++++++
>  2 files changed, 22 insertions(+)

This patch, commit 617e0491abe4 ("f2fs: sysfs: export linear_lookup in
features directory") upstream, needs to find its way into all Stable
branches containing upstream commit 91b587ba79e1 ("f2fs: Introduce
linear search for dentries"), which is essentially linux-5.15.y and
newer.

stable/linux-5.4.y:
MISSING:     f2fs: Introduce linear search for dentries
MISSING:     f2fs: sysfs: export linear_lookup in features directory

stable/linux-5.10.y:
MISSING:     f2fs: Introduce linear search for dentries
MISSING:     f2fs: sysfs: export linear_lookup in features directory

stable/linux-5.15.y:
b0938ffd39ae f2fs: Introduce linear search for dentries [5.15.179]
MISSING:     f2fs: sysfs: export linear_lookup in features directory

stable/linux-6.1.y:
de605097eb17 f2fs: Introduce linear search for dentries [6.1.129]
MISSING:     f2fs: sysfs: export linear_lookup in features directory

stable/linux-6.6.y:
0bf2adad03e1 f2fs: Introduce linear search for dentries [6.6.76]
MISSING:     f2fs: sysfs: export linear_lookup in features directory

stable/linux-6.12.y:
00d1943fe46d f2fs: Introduce linear search for dentries [6.12.13]
MISSING:     f2fs: sysfs: export linear_lookup in features directory

mainline:
91b587ba79e1 f2fs: Introduce linear search for dentries
617e0491abe4 f2fs: sysfs: export linear_lookup in features directory

> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs
> b/Documentation/ABI/testing/sysfs-fs-f2fs index
> 59adb7dc6f9e..0dbe6813b709 100644 ---
> a/Documentation/ABI/testing/sysfs-fs-f2fs +++
> b/Documentation/ABI/testing/sysfs-fs-f2fs @@ -846,3 +846,16 @@
> Description:	For several zoned storage devices, vendors will provide
> extra space reserved_blocks. However, it is not enough, since this
> extra space should not be shown to users. So, with this new sysfs
> node, we can hide the space by substracting reserved_blocks from total
> bytes. + +What:		/sys/fs/f2fs/<disk>/encoding_flags
> +Date:		April 2025 +Contact:	"Chao Yu"
> <chao@kernel.org> +Description:	This is a read-only entry to
> show the value of sb.s_encoding_flags, the +		value is
> hexadecimal. + +		===========================
> ========== +		Flag_Name                        Flag_Value +
> ===========================      ========== +
> SB_ENC_STRICT_MODE_FL            0x00000001 +
> SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002 +
> ===========================      ========== diff --git
> a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c index 3a3485622691..cf98c5cbb98a
> 100644 --- a/fs/f2fs/sysfs.c +++ b/fs/f2fs/sysfs.c @@ -274,6 +274,13
> @@ static ssize_t encoding_show(struct f2fs_attr *a, return
> sysfs_emit(buf, "(none)\n"); }
>  
> +static ssize_t encoding_flags_show(struct f2fs_attr *a, +
> struct f2fs_sb_info *sbi, char *buf) +{ +	return sysfs_emit(buf,
> "%x\n", +
> le16_to_cpu(F2FS_RAW_SUPER(sbi)->s_encoding_flags)); +} + static
> ssize_t mounted_time_sec_show(struct f2fs_attr *a, struct f2fs_sb_info
> *sbi, char *buf) { @@ -1158,6 +1165,7 @@
> F2FS_GENERAL_RO_ATTR(features);
> F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> F2FS_GENERAL_RO_ATTR(unusable); F2FS_GENERAL_RO_ATTR(encoding);
> +F2FS_GENERAL_RO_ATTR(encoding_flags);
> F2FS_GENERAL_RO_ATTR(mounted_time_sec);
> F2FS_GENERAL_RO_ATTR(main_blkaddr);
> F2FS_GENERAL_RO_ATTR(pending_discard); @@ -1270,6 +1278,7 @@ static
> struct attribute *f2fs_attrs[] = { ATTR_LIST(reserved_blocks),
> ATTR_LIST(current_reserved_blocks), ATTR_LIST(encoding), +
> ATTR_LIST(encoding_flags), ATTR_LIST(mounted_time_sec), #ifdef
> CONFIG_F2FS_STAT_FS ATTR_LIST(cp_foreground_calls), -- 2.49.0
> 

-- 
Lee Jones [李琼斯]

