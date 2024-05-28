Return-Path: <stable+bounces-47562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF18D1A8D
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 14:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BCAB270DB
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A513BAC4;
	Tue, 28 May 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ehuk.net header.i=@ehuk.net header.b="A8EKvy57"
X-Original-To: stable@vger.kernel.org
Received: from james.steelbluetech.co.uk (james.steelbluetech.co.uk [78.40.151.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23CC16D4C3
	for <stable@vger.kernel.org>; Tue, 28 May 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.151.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897779; cv=none; b=d20HfBs+xJvOB2d38QT+zerAI6Y64ElgqxAJgGVxg2X9k58Dphk0VF4e/I5JTyxzPV4ra+H0Y+U7rHT39eqnvn2Gk5WQ2ljyJTjZOV3uiYVHXQr+aSH6l4SLMfYxoFcVMsz/ZOhHPgQKMIY7NQtbDO+gohtR5E3I5Ima2vGLUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897779; c=relaxed/simple;
	bh=4wNaBVVOYb0RYlNmFgSVe1f/VrbCZo/sx6X79rNOX10=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=eoRTxf2/wrYzHVKbV5hyarClHwA9MA+1SWN5DtVGjnxeZSIcC8Wea41I/R5l8pWu8Eijn9KL55RdhfICNtZs9b8GlCouelKUaoz6Vf7OkMFVhtYcrPvI69adGkOBqozou9uPVKjFVZQMGC7zRoQ8hu/vjAMS9eUyR1cM1x3+PPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ehuk.net; spf=pass smtp.mailfrom=ehuk.net; dkim=pass (2048-bit key) header.d=ehuk.net header.i=@ehuk.net header.b=A8EKvy57; arc=none smtp.client-ip=78.40.151.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ehuk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ehuk.net
Received: from [10.0.5.25] (tv.ehuk.net [10.0.5.25])
	by james.steelbluetech.co.uk (Postfix) with ESMTP id E5374BFC19
	for <stable@vger.kernel.org>; Tue, 28 May 2024 12:58:08 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 james.steelbluetech.co.uk E5374BFC19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ehuk.net; s=default;
	t=1716897489; bh=etCr6BOKxM1khn69nsh9l3tglW2dTHYSJa1YbqP8GgM=;
	h=Date:To:From:Subject:From;
	b=A8EKvy57lZDtbS3sm1PTPTss83MqD7b8b45ugyleilGfV9HedtB6IjhXzNRsbBY2S
	 kQX1KzWXoaEy2DZNF13RwppoJ6GbrvHEbrZ7gjy0gW/F0UfFxgKNIQrD6S9KlKsn0I
	 i1gV7cEXfy2CzDb299iMtOOKvFBTPLi+NryNgvXcogb7nkSkkIm+VI5qu7lQ7bOBOl
	 xc5lKu6d0rMpD3Ufe4mT2W3L6I+VCzS4Rbj0b2FSS3nU2GVY2G2tUtkKwW/7Ot2L2T
	 GNkYBA/B4RGirCL/QOi2S0XoVfz35sE0HUCakd+eYhlu9bZXkyHvfSOI+8IGi6p+k6
	 ZbPWon1hMQ31w==
Message-ID: <d318505c-e54a-4478-b6bb-498a4d3bebb2@ehuk.net>
Date: Tue, 28 May 2024 12:58:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: stable@vger.kernel.org
Content-Language: en-GB
From: Eddie Chapman <eddie@ehuk.net>
Subject: Quick note, current 6.1 q successful test
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang

Just a quick note to say I've just booted 6.1.92, plus the 274 patches 
in the current stable queue applied, on an x86-64 workstation and no 
problems or issues to report, no unexpected errors in dmesg.

(AMD Ryzen, 3 x AMD gpu, sata, nvme, lots of USB, Gentoo, SELinux, KDE)

Eddie

