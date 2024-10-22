Return-Path: <stable+bounces-87781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9A99AB973
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 00:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493F41F22D03
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 22:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7975D1CDA3C;
	Tue, 22 Oct 2024 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DrudqmM1"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08421CCEED
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635911; cv=none; b=ipgFB1ukDzwSF96d22sJDmxK8vHS/5U3ISQhXPAdH17710HEtwCPZPdVzwphV5CV4JHP0zu2DdPRGo0/53K3Ez4S/XmN14gksa6ei0y+MFK7uFGDDe+B3h0BTzLgz+hp536FTjwZ5AiNWfSrF5awB9D0vs5B5AGyID5IxVpE7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635911; c=relaxed/simple;
	bh=Z1cZjeKf/jozcwiyWOWX+ZIBI+FWOzyh7DvqYvmsWkY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OxzlkL36ORjB3iYOz88mgwJj9C1kG2ETPj0sPWFkmPX3QwyeJhfCENaZhORUN1ntJPHV2esNAyUxJjHCmO+Y3LYbh2o/B6fNuI4vpnpD6ZsCh2yDKH7MmRMxfE3tFeXW4Y1Mr9BokdAol6w26XmimUIPquQ0pkIIjgckDzyzSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DrudqmM1; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b7d95a11so21293255ab.2
        for <stable@vger.kernel.org>; Tue, 22 Oct 2024 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729635909; x=1730240709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Wdl0kwphF2c8vv3SMO2fVvGpDrIoce+OneiyQG9nXE=;
        b=DrudqmM1sd5Mwww1nFxn8VCx7r6c+yPditOJ9DxYQP6N/f/4JTdymvUraWixrYwEDd
         Ml2DqF/DFKwnFg2w5TZ1G0oeBWVxBKh2a1aBnubeAFI2gN75gMgpTW02XMcrVo7IOOr5
         2DuADxGeaJJGq3G/nBq/EuKbkKZrtWT68ZMJKXyA6CWuHRaenBX51dhYXuvoECFFbzh0
         TyK86fM7fBKhAXxbvTBu5XkeG3RCPLh83e59qXPVpcz5IE/YXYuWB3124R4K+bzqTtXI
         pX7NP/DRl9S5zkbXrLVXya9ou2mLd3sn1TIYs/XdJ3T567z2Kl226EmEYfA+RMWvB3F7
         SCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729635909; x=1730240709;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Wdl0kwphF2c8vv3SMO2fVvGpDrIoce+OneiyQG9nXE=;
        b=jda/ynGcLDUkhnz8Yl+s4VbPozjdLGtAzbfMJz8HK08aKipdyFIq9AhVnqDNEfIy+O
         E8QyO1Ck/j9fLbKaIORpJcl9jC4x4szgZf5DeoX6VELta4ksJHr1oM5vrfuZT1OY48R4
         b/CtAfXMQQ9wSN4KY/P/MOhKFghQL0J5Q0FnVIoJVGWGNFrJ7KaeDTSsqtB+HonL2FNn
         dO/cZkXMEh2t7LQ6nhEHS+5F+0AEOuoJ/OWeiXqqNpCda1omZ7NT7bfaD4Va845LsRH7
         uxjunrww/v74eIt30/3kGCkdo5i23m+LJqrG9pbsPgZ1nZiv5VXExr6Y5o74ncwYn22F
         5YBA==
X-Forwarded-Encrypted: i=1; AJvYcCWlW2uV2PfgLWadOhgC3zu5OA+TNwsC24BoTMgO2wPKpWvFRkVOJApDjHhlLZwIMAjx/kozeuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHluRkDrIX7/KLRtJf8Uv1lRIByb0dvVE6QWNavXfn3KKW4Qs
	/2ndNSN9EtXgXFeNO9u9k58D8+2v5I3zbfxzQ+8t6G9mrnN9LzXK1E0w6YD8YPlcsyoqU6a/yCK
	Q
X-Google-Smtp-Source: AGHT+IFCHP8jHtw9I0EW/rBRRR87HKzXzIXgYn6ehqFfzqLjMc7iRS7Pvz2diCbQT9CFggYFStQ+0Q==
X-Received: by 2002:a05:6e02:13a6:b0:3a3:b1c4:8197 with SMTP id e9e14a558f8ab-3a4d5a00b6cmr7283545ab.23.1729635908957;
        Tue, 22 Oct 2024 15:25:08 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a65f952sm1767297173.176.2024.10.22.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:25:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Peter Wang <peter.wang@mediatek.com>, Chao Leng <lengchao@huawei.com>, 
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
In-Reply-To: <20241022181617.2716173-1-bvanassche@acm.org>
References: <20241022181617.2716173-1-bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Make blk_mq_quiesce_tagset() hold the tag list
 mutex less long
Message-Id: <172963590776.1032314.13124670972320527966.b4-ty@kernel.dk>
Date: Tue, 22 Oct 2024 16:25:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 22 Oct 2024 11:16:17 -0700, Bart Van Assche wrote:
> Make sure that the tag_list_lock mutex is no longer held than necessary.
> This change reduces latency if e.g. blk_mq_quiesce_tagset() is called
> concurrently from more than one thread. This function is used by the
> NVMe core and also by the UFS driver.
> 
> 

Applied, thanks!

[1/1] blk-mq: Make blk_mq_quiesce_tagset() hold the tag list mutex less long
      commit: 6fbd7e0472b73bc21b19d56d3f95c2a1a5456607

Best regards,
-- 
Jens Axboe




