Return-Path: <stable+bounces-28176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460C787C105
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 17:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FCE1C214BD
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B657319F;
	Thu, 14 Mar 2024 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="dLG7BlGV"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F47319E
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432739; cv=none; b=flUWVi2uIQbECGGYawX9rZSnR3ZYGzs8lt7F/Fh6oHRh9UXwVRIrtNzWF9nVS2vs9FqgWKc7fAeK8einjoa8i3Ddq+LgYuU3KB1mjBCt+in/l+NcL/krp7Lx74iy+P6Odg6kix5EtrCEUrT9wEPAeOSaOV3KBob9GiwswFJm/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432739; c=relaxed/simple;
	bh=PCA4oEGeHzergRYebAFkfnGjTh/er2Db/gz5H42uMWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuhQShNHmJjxPZn1BwVKF2BYQIUJuf9ryN6oyVZ2K5NL1VAmfsGtint29BHx8+Z0uScKge3B+1uFjuZdB80s44jm9l3m21XKOR8eYnVE85kIgq02PzYzdvz5YkFx1B28+Lsa0guYG/SO/VTT8k5qav8OUV3iOLg4X0Guq272G5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=dLG7BlGV; arc=none smtp.client-ip=17.58.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1710432735; bh=1luFzV2CPB2v/YqlRKWWzf4uwnz03g7Ye4zf7/eqxm4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dLG7BlGV8NylXoAI//Vb+4/4o+da8YCly/CXZCm2kgpQW7tfq2MFAtcCNGsIi7S7G
	 J0SlTwS0CO2aaI5uoE1vE2iBbntQ4rZ4uByY6eMmLES8MZTnIk5x7dj79j+Q8U0KQn
	 VnRmeiSHK/dgzy5BJsWAtFBDIZtUuiRF16O1UpFxlg7ciTtdpSyyxPIJ43nvwFd2Q/
	 gs/P6eGcwDh3Rmu8AGyBSRLj80ttCWRudfFYHVK8A79fOtlY0X6I7Sj693XypaC7Xb
	 aPQ6peNdQaD7csfwKLXC3MCCl+UYReQ+TRKKqGFkRrC0/N/cMwyDJKGC/DeW5qQHpq
	 XyLPvEz1An2Bg==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id BDCA63058A81;
	Thu, 14 Mar 2024 16:12:13 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: yukuai1@huaweicloud.com
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	junxiao.bi@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	song@kernel.org,
	stable@vger.kernel.org,
	yukuai3@huawei.com
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Thu, 14 Mar 2024 10:12:11 -0600
Message-ID: <20240314161211.14002-1-dan@danm.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <ecfce4d7-bcf7-c09a-7f01-5c7de88df107@huaweicloud.com>
References: <ecfce4d7-bcf7-c09a-7f01-5c7de88df107@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: n00SGHrE7BkMgWyyYDU0ShHBWmWW7znb
X-Proofpoint-GUID: n00SGHrE7BkMgWyyYDU0ShHBWmWW7znb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=984
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403140122

> How about the following patch?
> 
> Thanks,
> Kuai
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 3ad5f3c7f91e..0b2e6060f2c9 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -6720,7 +6720,6 @@ static void raid5d(struct md_thread *thread)
> 
>          md_check_recovery(mddev);
> 
> -       blk_start_plug(&plug);
>          handled = 0;
>          spin_lock_irq(&conf->device_lock);
>          while (1) {
> @@ -6728,6 +6727,14 @@ static void raid5d(struct md_thread *thread)
>                  int batch_size, released;
>                  unsigned int offset;
> 
> +               /*
> +                * md_check_recovery() can't clear sb_flags, usually 
> because of
> +                * 'reconfig_mutex' can't be grabbed, wait for 
> mddev_unlock() to
> +                * wake up raid5d().
> +                */
> +               if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
> +                       goto skip;
> +
>                  released = release_stripe_list(conf, 
> conf->temp_inactive_list);
>                  if (released)
>                          clear_bit(R5_DID_ALLOC, &conf->cache_state);
> @@ -6766,8 +6773,8 @@ static void raid5d(struct md_thread *thread)
>                          spin_lock_irq(&conf->device_lock);
>                  }
>          }
> +skip:
>          pr_debug("%d stripes handled\n", handled);
> -
>          spin_unlock_irq(&conf->device_lock);
>          if (test_and_clear_bit(R5_ALLOC_MORE, &conf->cache_state) &&
>              mutex_trylock(&conf->cache_size_mutex)) {
> @@ -6779,6 +6786,7 @@ static void raid5d(struct md_thread *thread)
>                  mutex_unlock(&conf->cache_size_mutex);
>          }
> 
> +       blk_start_plug(&plug);
>          flush_deferred_bios(conf);
> 
>          r5l_flush_stripe_to_raid(conf->log);

I can confirm that this patch also works. I'm unable to reproduce the
hang after applying this instead of the first patch provided by
Junxiao. So looks like both ways are succesful in avoiding the hang.

-- Dan

