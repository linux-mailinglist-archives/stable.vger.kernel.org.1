Return-Path: <stable+bounces-92987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAB89C87DF
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 11:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9209E28619D
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 10:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E31F7097;
	Thu, 14 Nov 2024 10:41:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E913A3EC;
	Thu, 14 Nov 2024 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580903; cv=none; b=JX2IY9vHb699fhG1PSvFzh6xFYBIxKxWcnrCvaid/MPPpK9TMyoEgCKCAnoBDOWeYP/mcNPFwvflyro9vrjYfIUnqIbWfh+NjbUb5juW0UrAbKbFzIMQ5iT7QzLqAGHFCTW2dMWQoFQ6eFzPS0pFFwpHGU2C8yj1UzjXrTgCzvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580903; c=relaxed/simple;
	bh=5/XN2yxVu+U9puVJG+0u6hyp9c6YHtVO/9QbauFX12I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lBQ1ige5ftGSPYZQfyLDpkT9KryPh3/jQjXKTMsv5DmhgjtVaJ2xDnaIDHmC36wIF5BY/mcRlX9EiZwWCTNvsDZO4R3OH7huFeGPB2rbLZWGxSb/NbjNmDZEbKk/B+wiJMDiyKlHclAacRvDx14wBKweU30yl8jWgJtOJPG5Swk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D61E61C000E;
	Thu, 14 Nov 2024 10:41:35 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1tBXI7-000g3w-0Z;
	Thu, 14 Nov 2024 11:41:35 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc: gregkh@linuxfoundation.org,  michal.vrastil@hidglobal.com,
  michal.vodicka@hidglobal.com,  linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] Revert "usb: gadget: composite: fix OS descriptors
 w_value logic"
References: <20241113235433.20244-1-quic_eserrao@quicinc.com>
Date: Thu, 14 Nov 2024 11:41:35 +0100
In-Reply-To: <20241113235433.20244-1-quic_eserrao@quicinc.com> (Elson Roy
	Serrao's message of "Wed, 13 Nov 2024 15:54:33 -0800")
Message-ID: <875xoqxfkw.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: peter@korsgaard.com

>>>>> "Elson" == Elson Roy Serrao <quic_eserrao@quicinc.com> writes:

 > From: Michal Vrastil <michal.vrastil@hidglobal.com>
 > This reverts commit ec6ce7075ef879b91a8710829016005dc8170f17.

 > Fix installation of WinUSB driver using OS descriptors. Without the
 > fix the drivers are not installed correctly and the property
 > 'DeviceInterfaceGUID' is missing on host side.

 > The original change was based on the assumption that the interface
 > number is in the high byte of wValue but it is in the low byte,
 > instead. Unfortunately, the fix is based on MS documentation which is
 > also wrong.

 > The actual USB request for OS descriptors (using USB analyzer) looks
 > like:

 > Offset  0   1   2   3   4   5   6   7
 > 0x000   C1  A1  02  00  05  00  0A  00

 > C1: bmRequestType (device to host, vendor, interface)
 > A1: nas magic number
 > 0002: wValue (2: nas interface)
 > 0005: wIndex (5: get extended property i.e. nas interface GUID)
 > 008E: wLength (142)

 > The fix was tested on Windows 10 and Windows 11.

 > Cc: stable@vger.kernel.org
 > Fixes: ec6ce7075ef8 ("usb: gadget: composite: fix OS descriptors w_value logic")
 > Signed-off-by: Michal Vrastil <michal.vrastil@hidglobal.com>
 > Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>

Acked-by: Peter korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard

