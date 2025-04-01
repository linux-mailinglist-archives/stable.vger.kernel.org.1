Return-Path: <stable+bounces-127281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6CAA77209
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 02:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF323A61F9
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 00:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B86F099;
	Tue,  1 Apr 2025 00:44:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cosmicgizmosystems.com (beyond-windows.com [63.249.102.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D75103F
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.249.102.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743468258; cv=none; b=aV50+BKYrdtc+aNwLNyDuxQGn3y7HO/cbjDxV5B9/OnD2O2IqlOhDdf9sKROaGPM9OSm3GjVRdysm4Av590exS8jWVVLebginaRBjjdXmE9Bv6Dqyd2UoE2NF5yH2UtBfhxXj4P8wZ7OWqiJLlB3gptyP4d7kKlANhNoX23MMGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743468258; c=relaxed/simple;
	bh=nxxfHm9OEzvv/qROIZTkmMGJrk33XE7zsBlvqvqunc4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cL8w4ulDW0BNN42tXdjI3frHZ08KAZ9uzj3ok/MFvDhtVd3pdBYIjRKQltHHf69LN6rG1ARwR5TDk+BJRrDXN3S01dIyLuFxqI1s3tynTm2ywQoJ7ZCEZvEfCFkb0u2dhNbeQT5m5NITnMTBRT4kfNvu4rOWOlE2QK7xK8Lmykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicgizmosystems.com; spf=pass smtp.mailfrom=cosmicgizmosystems.com; arc=none smtp.client-ip=63.249.102.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicgizmosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cosmicgizmosystems.com
Received: from [10.0.0.100] (c-71-63-147-217.hsd1.wa.comcast.net [71.63.147.217])
	by host11.cruzio.com (Postfix) with ESMTPSA id E4ABB1D184F6;
	Mon, 31 Mar 2025 17:34:34 -0700 (PDT)
Message-ID: <16adf217-c851-4378-bc4f-a9ccfc361120@cosmicgizmosystems.com>
Date: Mon, 31 Mar 2025 17:34:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>,
 "Wang, Wade" <wade.wang@hp.com>
From: Terry Junge <linuxhid@cosmicgizmosystems.com>
Subject: Upstream patch pairing request
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg and Sasha,

The following two patches have now been applied to mainline.

commit 486f6205c233da1baa309bde5f634eb1f8319a33
ALSA: usb-audio: Add quirk for Plantronics headsets to fix control names

commit 9821709af892be9fbf4ee9a50b2f3e0604295ce0
HID: hid-plantronics: Add mic mute mapping and generalize quirks

It would be ideal if both of these patches could flow upstream together although neither actually depends on the other. A verbose description of the user experience with neither, one, the other, or both patches applied can be found here:

https://lore.kernel.org/all/f107e133-c536-43e5-bd4f-4fcb8a4b4c7f@cosmicgizmosystems.com/

Let me know if there is anything I can do to help.

Thanks,
Terry


