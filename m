Return-Path: <stable+bounces-5267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A657C80C3EB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2390EB208A6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26402210E8;
	Mon, 11 Dec 2023 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CmZ47s6S"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461BBAD
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 01:02:18 -0800 (PST)
Message-ID: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702285336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=twFErpdMDUamHOKgEbk090Z9HhUyhQRUCJzpvfi+Yy4=;
	b=CmZ47s6SIbRL6DeAw99UlIg/knaaYyzXQUj7gc6v96PffZo/4UwzhC0wlcYZgn88DXBwb0
	LxcTKz4fu+tPF4TloobUmJ3bvcA4keKcg3nVQuAR0mVvJtBWIZ50PcPmUkGLK7MxOFlSDp
	ccgsRZPUS+AH5dvDxmGv40q3eR9O+4q9hiTfNZ0fgOSBJzoc/2Ai1aSP5g8jCXg58trgnq
	xg/FyN6Lk6ejOXKIQe1m5CgVVZHdyHUq1Ylk/kftzPv421QsMN2MpVZsQFCIggeTeMbT6M
	BS3cAXsokcrUCOthmU8zR/jhoiEKGXjElMNDmWc3iwAUOQK5zGlihcsIjvc8Jg==
Date: Mon, 11 Dec 2023 16:02:11 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Johannes Berg <johannes.berg@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Subject: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for non-range
 use
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

Hi Johannes, hi Greg,

Any tree that back-ported 7e7efdda6adb wifi: cfg80211: fix CQM for 
non-range use that does not contain 076fc8775daf wifi: cfg80211: remove 
wdev mutex (which does not apply cleanly to 6.6.y or 6.6.1) will be 
affected.

You can find a downstream bug report at Arch Linux:

https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/17

So we should either revert 7e7efdda6adb or backport the needed to those 
kernel series. 6.7.y is reported to work with 6.7.0-rc4.

-- 
Best, Philip

