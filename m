Return-Path: <stable+bounces-235952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF4YHOmj3GkEUgkAu9opvQ
	(envelope-from <stable+bounces-235952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:06:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A683E8C79
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9323B300644F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853E63A4538;
	Mon, 13 Apr 2026 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEIMxxgB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FF3A4502
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067555; cv=none; b=huEGT0XXcW7E4u/LTTju5cvItx8D3VS6LPuVrjUgq/Rd9P1xMVv0O6iiMLDbXzdh6PgexesYjIkjvj/3FjGbfkFZQS2phr9OKPWgDYb9ErSEInfNh26PaYIZNFrxCsaUwT/6le3wZVxOBrTOpGnSCYCFACPDrASblM1rg8gO6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067555; c=relaxed/simple;
	bh=vrwUFCru5QZH0nEP+ZUEk+gXOzpnasIkjfdMXPqDJMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BU4sKWJ0DW/ZdSiK4rrL4468B4LSGaYkmf04+Tc9boF/spMbA+gw9MjeoMPtXetCxujcdTf/BSq9Mr1CmS9oDFlFiTMkhu0wvspb4q9qmx9pmtbaRH6v+m0NKRkjrFF+CdlFlNzURRinKfV8yxSRggx7QIjiHwSThmjZsAdcbtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEIMxxgB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so2430652f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067552; x=1776672352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO2Hpq2Jz6wGmzry72RzTB9Uqdau8hUZxvRSy5IF2tk=;
        b=IEIMxxgBK72O2a+ztuGguoKPnebWyNauNaEQpnHPuzdWk9DPI8DezRxrd1S35QCvcW
         Xos2oHudmke8Kcw+FsLOe3wwMqlYTp67k5TpQbJTIZ8NB9i56eGOx5dOhClO8OKMKU6M
         r+7zvE9px2H2XFH6el93bwt5ce25r9rxE6kj7TfIx5tL1H7CnS5oGRVb7A21TlRkkXlE
         60gcmPRNzu0IizpC3jEl+cbBolJ1ewIcfv91Duaq286WClTJ+xS3vD98+U122lkHtza1
         51gabwyHS0q7D9hMKxFgua1lj8HNhaHen6rVtulibDsMTYANy3334aLZm1v9A5AgvSUN
         i2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067552; x=1776672352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WO2Hpq2Jz6wGmzry72RzTB9Uqdau8hUZxvRSy5IF2tk=;
        b=o8YNSIUkcZuDaj9I1RgyTmZLNq703q005RmtvcCRNKOw82M2BRoqZZiSxCPFFRypQw
         XhzLtmPj7mv8zxbUdIYsUkFVePmzbjCfo9ZoWS2yl4MkvnBWcSQ2B5dkj4ci3VhJrwoo
         l4jiXDeeI2kddzSX8D50+xCz8bZKvhwzSu2RBPYc4Fj7g3nFPZYVBsop9Hb4huHUBfZh
         oljiDh5HKhGEfT+gUJghupyt74slV82Oe8I0pi6yREc2MnmPv77x9CxxzsdLdP+GVYcQ
         HHW8GgBC4ilWpi6/1Fz/DkURaAzgjeqy4l0WO97LJKldhbdh/sde8m/0dSTdlTS3kMez
         TrNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YFAugg3SEdpO3m02UCKwafBNdXf1sHbc6JlBmuNNVXSENX2O7kSFvnnLaQfV6cHyo6mRRG0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOwbI33gnIAJagnxjMmobp8M9Y1885WVUr7tqYvVgb7mJPxCN6
	8sfPLteqpBio2qY3GrbMItKbUoKYEP1dcyUpSnEqcZ2YvWXl9VkeU/zV
X-Gm-Gg: AeBDiesAm3ZxDcPH8vTq6NSDoZWWtB4IOCqnXVcm9tzuU9KuZmFzPloOYRKyzek/MPf
	WoIDDFUhsnlm08/ko90p+mkDxAlo1MfxQScIC6a9kyEk7Pwo6YcMnz3wnaEDN+ksdVzX2rjEMv3
	u5ljiaytCuw9ZMW6rdR5FSk9Kzn3OU+7K3a6+Y3E2FhfKUl9FkBFSB7SUIY4d/lWM74Gx+ys4vZ
	Hskd1AaH7zTOwyqLIutAymQvMlPUXxRUT8k4lp4XS6fGcaB2adAKDJ1n78mKJuAwzt8uHycP1nz
	85Nkvs9g6pbh5LW/1/aNEDlBC6XGhs8YTba3cIH8sjfN+VgLnYzwYQVffzMflDLW2CJtZ0X5ckB
	qrkpHvkAHE7tGh4AW2BD8SjzxRHa2KmDEDUnZkPGgsJc0/cy170PhlFQWeM459ICRKtmTktWKU0
	o5HHgEeCi969Vi6vehOKqXk2T1ahQkRDAWtfR1uzmHYZf4PA==
X-Received: by 2002:a5d:5f50:0:b0:43c:f7e5:817b with SMTP id ffacd0b85a97d-43d64271246mr17964446f8f.19.1776067550338;
        Mon, 13 Apr 2026 01:05:50 -0700 (PDT)
Received: from foxbook (bfi125.neoplus.adsl.tpnet.pl. [83.28.46.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5ccdasm33107221f8f.34.2026.04.13.01.05.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Apr 2026 01:05:49 -0700 (PDT)
Date: Mon, 13 Apr 2026 10:05:45 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Jeffrey Hein <jp@jphein.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Ricardo Ribalda
 <ribalda@chromium.org>, Alan Stern <stern@rowland.harvard.edu>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede
 <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 2/3] media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for
 fragile firmware
Message-ID: <20260413100545.71796c66.michal.pecio@gmail.com>
In-Reply-To: <CAD5VvzCEV_XbHc_Gby7mFPBSgSebqKDKJf3VC8HNRrD+xWaTJg@mail.gmail.com>
References: <20260331003806.212565-1-jp@jphein.com>
	<20260331003806.212565-3-jp@jphein.com>
	<CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com>
	<20260409100247.7cfb62d1.michal.pecio@gmail.com>
	<20260409221749.5e6bccab.michal.pecio@gmail.com>
	<c4275422-a9b4-4519-95f9-1163a7912709@linux.intel.com>
	<CAD5VvzCEV_XbHc_Gby7mFPBSgSebqKDKJf3VC8HNRrD+xWaTJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235952-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8A683E8C79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 16:06:43 -0700, Jeffrey Hein wrote:
> Test 1: Michal's xhci patch + JP's UVC patches + NO_LPM
> =========================================================
> Active: usbcore.quirks=1532:0e05:k (NO_LPM), DKMS uvcvideo with
> UVC_QUIRK_CTRL_THROTTLE, Michal's xhci patch.
> 
> Result: HC died. The crash sequence from the full log:
> 
> 1) 437 repeated Cancel/resubmit cycles on EP5 IN (ep 0x85, slot 5
>    ep 10) over ~7 minutes starting mid-call:
> 
>   [15:18:58] Cancel URB 0000000028356cb5, dev 3.1, ep 0x85, starting
> at offset 0x114a49080
>   [15:18:58] Stopped on Transfer TRB for slot 5 ep 10
>   ... (437 cancel/resubmit cycles through 15:26:04)
> 
>    This is the same "repeated unlinks on EP5IN" pattern you noted in
>    the March 30 stall-6.17-stress-during-call log, Michal.
> 
> 2) After the last ep 0x85 cancellation + endpoint reconfigure (add
>    ep 0x81), ~994,000 spurious SHORT_PACKET events (comp_code 13)
>    flooded the HC for ~5 minutes:
> 
>   [15:26:04] add ep 0x81, slot id 5
>   [15:26:04] Successful Endpoint Configure command
>   [15:26:04] Spurious event dma ..., comp_code 13 after 13

That's not abnormal and it probably shouldn't be logged at all.
I filtered out some of this noise from subsequent log snippets.

This is interesting because it shows the isochronous video endpoint
being enabled and then stopped and removed shortly after:

[Fri Apr 10 15:26:04 2026] xhci_hcd 0000:00:14.0: add ep 0x81, slot id 5, new drop flags = 0x0, new add flags = 0x8
[Fri Apr 10 15:26:04 2026] xhci_hcd 0000:00:14.0: xhci_check_bandwidth called for udev 00000000921e7e25
[Fri Apr 10 15:26:04 2026] xhci_hcd 0000:00:14.0: // Ding dong!
[Fri Apr 10 15:26:04 2026] xhci_hcd 0000:00:14.0: Successful Endpoint Configure command
[Fri Apr 10 15:26:05 2026] xhci_hcd 0000:00:14.0: Cancel URB 0000000009b97440, dev 3.1, ep 0x81, starting at offset 0x2db0885f0
[Fri Apr 10 15:26:05 2026] xhci_hcd 0000:00:14.0: // Ding dong!
[Fri Apr 10 15:26:05 2026] xhci_hcd 0000:00:14.0: Stopped on Transfer TRB for slot 5 ep 2
[...]
[Fri Apr 10 15:26:05 2026] xhci_hcd 0000:00:14.0: drop ep 0x81, slot id 5, new drop flags = 0x8, new add flags = 0x0

Then EP5IN submit/unlink cycles continue.
And video starts again:

[Fri Apr 10 15:26:09 2026] xhci_hcd 0000:00:14.0: add ep 0x81, slot id 5, new drop flags = 0x0, new add flags = 0x8
[Fri Apr 10 15:26:09 2026] xhci_hcd 0000:00:14.0: xhci_check_bandwidth called for udev 00000000921e7e25
[Fri Apr 10 15:26:09 2026] xhci_hcd 0000:00:14.0: // Ding dong!
[Fri Apr 10 15:26:09 2026] xhci_hcd 0000:00:14.0: Successful Endpoint Configure command

Transfer error followed by normal operation, seems harmless so far:

[Fri Apr 10 15:29:04 2026] xhci_hcd 0000:00:14.0: Transfer error for slot 5 ep 2 on endpoint
[Fri Apr 10 15:29:04 2026] xhci_hcd 0000:00:14.0: Error mid isoc TD, wait for final completion event
[Fri Apr 10 15:29:04 2026] xhci_hcd 0000:00:14.0: Transfer error for slot 5 ep 2 on endpoint
[Fri Apr 10 15:29:04 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x000000028c6fb7e0, comp_code 13 after 13

EP0 stall, not seen before. A bit suspicious, but video still runs:

[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x00000002db088de0, comp_code 13 after 13
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x00000002db088e10, comp_code 13 after 13
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Stalled endpoint for slot 5 ep 0
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Hard-reset ep 0, slot 5
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: // Ding dong!
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Ignoring reset ep completion code of 1
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Removing canceled TD starting at 0x114a485c0 (dma) in stream 0 URB 000000000ffbecf4
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Set TR Deq ptr 0x114a485f0, cycle 0
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: // Ding dong!
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: xhci_giveback_invalidated_tds: Keep cancelled URB 000000000ffbecf4 TD as cancel_status is 2
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x00000002db088e40, comp_code 13 after 13
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Successful Set TR Deq Ptr cmd, deq = @114a485f0
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: xhci_handle_cmd_set_deq: Giveback cancelled URB 000000000ffbecf4 TD
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Giveback URB 000000000ffbecf4, len = 0, expected = 4, status = -32
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: xhci_handle_cmd_set_deq: All TDs cleared, ring doorbell
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x00000002db088e80, comp_code 13 after 13
[Fri Apr 10 15:30:26 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x00000002db088eb0, comp_code 13 after 13

EP0 timeout and unlink, video endpoint fails shortly after:

[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x000000028c6fbe30, comp_code 13 after 13
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x000000028c6fbe60, comp_code 13 after 13
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Cancel URB 0000000008ead041, dev 3.1, ep 0x0, starting at offset 0x114a48290
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: // Ding dong!
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Stopped on Transfer TRB for slot 5 ep 0
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Removing canceled TD starting at 0x114a48290 (dma) in stream 0 URB 0000000008ead041
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Set TR Deq ptr 0x114a482c0, cycle 0
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: // Ding dong!
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: xhci_giveback_invalidated_tds: Keep cancelled URB 0000000008ead041 TD as cancel_status is 2
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Successful Set TR Deq Ptr cmd, deq = @114a482c0
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: xhci_handle_cmd_set_deq: Giveback cancelled URB 0000000008ead041 TD
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Giveback URB 0000000008ead041, len = 2, expected = 2, status = -115
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: xhci_handle_cmd_set_deq: All TDs cleared, ring doorbell
[Fri Apr 10 15:30:48 2026] usb 2-3.1: ThreadPoolSingl timed out on ep0in len=2/2
[Fri Apr 10 15:30:48 2026] usb 2-3.1: Failed to query (GET_CUR) UVC control 6 on unit 1: -110 (exp. 2).
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x000000028c6fbe90, comp_code 13 after 13
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x000000028c6fbec0, comp_code 13 after 13
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x000000028c6fbef0, comp_code 13 after 13
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x000000028c6fbf30, comp_code 13 after 13
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Spurious event dma 0x000000028c6fbf60, comp_code 13 after 13
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Transfer error for slot 5 ep 2 on endpoint
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Miss service interval error for slot 5 ep 2, set skip flag
[Fri Apr 10 15:30:48 2026] xhci_hcd 0000:00:14.0: Miss service interval error for slot 5 ep 2, set skip flag

Now things are properly broken. Next EP0 URB times out too:

[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: Cancel URB 000000008f70ed5c, dev 3.1, ep 0x0, starting at offset 0x114a482c0
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: Set TR Deq ptr 0x114a482f0, cycle 0
[...]
[Fri Apr 10 15:30:53 2026] usb 2-3.1: ThreadPoolSingl timed out on ep0in len=0/2
[Fri Apr 10 15:30:53 2026] usb 2-3.1: Failed to query (GET_CUR) UVC control 6 on unit 1: -110 (exp. 2).

Fololwed by Transaction Error on the next and subsequent ones:

[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: Transfer error for slot 5 ep 0 on endpoint
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: TRB error 4, halted endpoint index = 0
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: Hard-reset ep 0, slot 5
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: // Ding dong!
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: Ignoring reset ep completion code of 1
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: Removing canceled TD starting at 0x114a482f0 (dma) in stream 0 URB 000000000ca6398c
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: Set TR Deq ptr 0x114a48320, cycle 0
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: // Ding dong!
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: xhci_giveback_invalidated_tds: Keep cancelled URB 000000000ca6398c TD as cancel_status is 2
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: Successful Set TR Deq Ptr cmd, deq = @114a48320
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: xhci_handle_cmd_set_deq: Giveback cancelled URB 000000000ca6398c TD
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: Giveback URB 000000000ca6398c, len = 0, expected = 2, status = -71
[Fri Apr 10 15:30:53 2026] xhci_hcd 0000:00:14.0: xhci_handle_cmd_set_deq: All TDs cleared, ring doorbell
[Fri Apr 10 15:30:53 2026] usb 2-3.1: Failed to query (GET_CUR) UVC control 6 on unit 1: -71 (exp. 2).

It seems the driver stopped resubmitting video URBs here and issued
some control transfer. It timed out and unlinking crashed the HC.

[Fri Apr 10 15:30:54 2026] xhci_hcd 0000:00:14.0: Miss service interval error for slot 5 ep 2, set skip flag
[Fri Apr 10 15:30:54 2026] xhci_hcd 0000:00:14.0: Miss service interval error for slot 5 ep 2, set skip flag
[Fri Apr 10 15:30:54 2026] xhci_hcd 0000:00:14.0: Overrun event on slot 5 ep 2
[Fri Apr 10 15:30:54 2026] xhci_hcd 0000:00:14.0: Skipped one TD for slot 5 ep 2
[Fri Apr 10 15:30:59 2026] xhci_hcd 0000:00:14.0: Cancel URB 000000007f4f069a, dev 3.1, ep 0x0, starting at offset 0x114a48770
[Fri Apr 10 15:30:59 2026] xhci_hcd 0000:00:14.0: // Ding dong!
[Fri Apr 10 15:31:04 2026] xhci_hcd 0000:00:14.0: Command timeout, USBSTS: 0x00000000
[Fri Apr 10 15:31:04 2026] xhci_hcd 0000:00:14.0: xHCI host not responding to stop endpoint command

---

Question: can you kill it by starting some video application to set the
camera up, closing it and then running this loop?

while :; do v4l2-ctl -d /dev/video0 --stream-mmap --stream-count=1; done

Regards,
Michal

