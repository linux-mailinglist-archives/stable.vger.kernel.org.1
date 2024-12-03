Return-Path: <stable+bounces-96311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4619E1E06
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C011665C9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A811F76AD;
	Tue,  3 Dec 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oOOtdoCJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EAF1F7092
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233333; cv=none; b=TAbETjNssy4pPhd7lCtoe3thUFYZswZp5lEu7t+tT8xX4UDZ6lch9mnS//dkVGsMOy1CRk2bz7zAhlupJyhBcmb8dFwN7URSPMK0pNXGqz+gsTaGjLBDVv1RZ07UE/SEhJhv+y1rZUOzXzRe8M1TJIIsBROG8Y48dUyhX1cfb94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233333; c=relaxed/simple;
	bh=36xPLTAUY/4j3MR36/YfNWQZr3nAE8BYS/fpyZmmhOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qBOoqO6RoHqBmWMeg8AFjBQqunvtGy0A+r8dfrC6203W+0q5XibfTIDr0eSPzba/z9Lu5LDKyA6ucD4ZzFfEoqGIaMOFAcNixIFOy+K3/wBQo+TtQH3Nh6cUqYD5ytEwoiUGS3el/V68ScCHP3XP+Qo3R9sKiTgaTmg1V2P5z/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oOOtdoCJ; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f22ea6d645so1819120eaf.2
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 05:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733233329; x=1733838129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0SvBk5G5le5K/7q79/RVIGjbUUaJmu/spAdFOeFVzc=;
        b=oOOtdoCJmI0Gjl7eP3lzvLOAi3iu1hMCfdWFX1YRRT78Ymtlygy2df+gF6nxJh81Bk
         GTDv/bUEoiVeFvWyLvYy6KguQo04t2KTY5Sv9NAV1yWSM+7vih8E5oxWj0l/Cv5eJSnH
         7Q9/wPWRcbprztBhiu1r47mqghJNRimjdFnP6bVmfXHwVhrIFvjViD5t/5lPVqU5/IQ9
         HlwUHTP9Lg+C7s2RjFXfheHHbjISa1/X3mBhz2UvT3A+mKIamo4PcNvXYZdA+srSJe1B
         OHnuAuqGReLW+v12+KEekHKsYfgkC5ceJQrPO6LGZzIBW3g14LHY+cJOCn6MZdk9MpOB
         4wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233329; x=1733838129;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0SvBk5G5le5K/7q79/RVIGjbUUaJmu/spAdFOeFVzc=;
        b=GVv3AitiB2ZL7v8hzypuf/V2+xO1HNg+XAFp//28OwdCBlQjuWnS25AIlNghTBiOUH
         VdbBYXfnJ7UT2eG/XdsfMUBg2piRgYC+Q1f0MXNuySw6fC9Hp4qInwtPH7Ol6OYF1FNY
         sHvl2AXSJczHYDhe4lgNPZ6LFjj+Y/h3arUJWi+8WA98l14OPBAr8ur0Ryj3RKa42VRJ
         1LJXqgxl7iQpqViGPo4DkCsfdC7LbWzrJ7feZHLdm1jpOKHGIYHRXlkYdC7k9MVD9TFP
         SLcgpA4KVLfwdq2qUHIlUw1mnzAHli+b9sAOPvKeyRLspT3k9DjZ3goMuKbgCSdjneoc
         HkIg==
X-Forwarded-Encrypted: i=1; AJvYcCXIj6b8a4Q2pAMkUHlMyCMN1VwHhmmqe2J6WiComJkRRF0Pwt1xH2dAVV9eE6jig+PymCCLlvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzniYsJEqbum744sZbUYTP0Gv4RhhVDipAwES7ElvhMU7i3CrPN
	BNjXmlGD8xD9oCHyqwUSPZ65PWDUGwxfNwxkUzN0OFTmUekeFOccLjd/Przy/nw=
X-Gm-Gg: ASbGncuyBu4bxhCSKnAJpTS88jjZ3aOChOkYmY/uP1d0pwxX9kn7Tfw/473tGC+k+AN
	+cFcYEx5NgWn4dM9En6Ewev1MF1/Aw1eyWvFXiCAoouGnpO/zeuIFCZl0hJ77uq8+pYIamjS/yb
	xyKSxc4XVgVXmUUdHSH7AWjZDHbNrllceKYjVJpaoFA+X94j40wpDNBe4t1E6qhgovF2PWEaYsE
	X0w3tJ5/98nb1ltd8WDsnCv7udmqYxgPKgwgLnhY233Kg==
X-Google-Smtp-Source: AGHT+IHK7p+Wgs7gWgFtwXcFiQ3a7tGFw96+K4ZeLiJyn41akIl/veSD3a0bPNMAPllNfN7Vr8rrPw==
X-Received: by 2002:a05:6820:991:b0:5ee:e899:3654 with SMTP id 006d021491bc7-5f25ad53258mr2698962eaf.2.1733233328925;
        Tue, 03 Dec 2024 05:42:08 -0800 (PST)
Received: from [127.0.0.1] ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f21a4cd86bsm2782124eaf.29.2024.12.03.05.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:42:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Kanchan Joshi <joshi.k@samsung.com>, Bernd Schubert <bschubert@ddn.com>
Cc: io-uring@vger.kernel.org, stable@vger.kernel.org, 
 Li Zetao <lizetao1@huawei.com>
In-Reply-To: <20241203-io_uring_cmd_done-res2-as-u64-v2-1-5e59ae617151@ddn.com>
References: <20241203-io_uring_cmd_done-res2-as-u64-v2-1-5e59ae617151@ddn.com>
Subject: Re: [PATCH v2] io_uring: Change res2 parameter type in
 io_uring_cmd_done
Message-Id: <173323332799.59116.14437806909916721347.b4-ty@kernel.dk>
Date: Tue, 03 Dec 2024 06:42:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 03 Dec 2024 11:31:05 +0100, Bernd Schubert wrote:
> Change the type of the res2 parameter in io_uring_cmd_done from ssize_t
> to u64. This aligns the parameter type with io_req_set_cqe32_extra,
> which expects u64 arguments.
> The change eliminates potential issues on 32-bit architectures where
> ssize_t might be 32-bit.
> 
> Only user of passing res2 is drivers/nvme/host/ioctl.c and it actually
> passes u64.
> 
> [...]

Applied, thanks!

[1/1] io_uring: Change res2 parameter type in io_uring_cmd_done
      (no commit info)

Best regards,
-- 
Jens Axboe




