Return-Path: <stable+bounces-241223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFKMDUIF72ma3wAAu9opvQ
	(envelope-from <stable+bounces-241223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:42:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A16DD46DB98
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C05E3303B7C2
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 06:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDA7384256;
	Mon, 27 Apr 2026 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCrrnBGQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722D3815E7
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271763; cv=none; b=LDWZQxwSE0Tdm8Q1z4M/+B56momNPVWJXZetzRYoqbwGk6xXDq8Bmublbu+ylcrDEyiAa0Bb5K7E2vqi1oJez+Ay3UauKHnQDGzPIlhEEcCfbbcDl0BVjK6nVR2zMGYseIqPcjyVLCzUBaOU4SM0BKufVKXakPDXcH+KX45/dsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271763; c=relaxed/simple;
	bh=DoIRs2ewmXmKoxeu+LwDciZNxgzLEyxBy3ROzfHrEhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kU6AERuDAuo4pcjnRmeoLN45DY6BvZ3JMbGid0k/jIAWRpB7vBLMeVYfLjH0TW6L4yN6EMeavI8XuPoBogIvOpaPRE2f+p9gJ/aik+M+TdAPWFEU6TfNM15JI8nB7b1Fjs5MYaF4tvS4QB7eWllFQ6m6Zw6DbYaAwq0HApDKifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCrrnBGQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a402dea4a5so9872585e87.2
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 23:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777271760; x=1777876560; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob6hAxn4b2XJbstB2WIYNRqhZDHJqLJB6rp2bFlZgjg=;
        b=DCrrnBGQZlmqii1jcrhEBQ1AmWiOgMsjDskG4yKdb2+p+TAnpVP8TVJiiOsmdOxZoS
         VczEHy7xxhZdiUlTZkzGMEkTL7cRbEtGaQadNzn6OozG9k//Ps5xdf51qYxcqOJx717t
         /q96bkCHL7QdLBwBTnXrJ0Xhn5dXs7tqSMLj2DJIiuUExhwYXVc/1c0UicaJNqXn3gqC
         yQAhtSWv2spmp4R1o+pOsSAuTV4RuFAXhBehFc/Uai6twFt4msZvXoFFfS5E0lasjksw
         4eQUHVvIswPgzTdyyWGiNRCWcz08erDSqJbnP0qs2zI53ag1ftceIJmPMnpfuizk8jbc
         IA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777271760; x=1777876560;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ob6hAxn4b2XJbstB2WIYNRqhZDHJqLJB6rp2bFlZgjg=;
        b=OVpcH7JoWcmvx+o/REDE/aHjmLcszQLpTWH8rR3GHxr4W/6+cFpr+2M8kYCw18KYIJ
         +VBdZy9aqt6yenYRXilo0BfYb2LxGXmvGP65kjlr5Bv8at9RCEZHHFYa5zgvq7lcRQ01
         r5J4mH0a5ZG4tmn0aTJYRmlkbgV1VBzTlmVjOsBkRhvi8KDv6C5x4icHse0g4ohBEWwK
         D3uursv1frI+LGs4Si0x9XTparVCHSwZfYSCpyunZVInvpoRtBS6eqK8dXbkM9ISdD4H
         M1VMN7TCl13+b2UJ87WlkNIwP+Of/7P03EhXx8eXRtMOAMMowuuR64g8YB7leg1IC4P8
         sK+w==
X-Forwarded-Encrypted: i=1; AFNElJ8IgcLd9noYwqhAcBy0XmhepNaNnare6Ji6OiuSZBvr8MR6RlMngNK7fUXYXbS3+To6CoqAD74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjRYrcyX2AcpJa+v3JII/hWwpHuet/r8fY8CVw2xwYpJKcLJpH
	Sau40JA65c4TTqNAbhuYGLwyqqJegBC/FUHaq1PExLzXU1/yJUQYuisR
X-Gm-Gg: AeBDietDoGVVsK0hw7PLqlku7gu1b0LSofRqJbNVwPDILpKe7kdU9SLaojBntN85DZZ
	vD+XwNc8nTL1bJjZjFOr3s0ZvFvSQbi0Q6LuBV1N9k2psxKHfZvzfstOO6T0ziM3FU/DNvwXnjW
	JFawXSYH9C7RGCEdzQ/hxeDbhQcaea0lFLMAEX2L0xEgAIh/WH5aWyy2wNkgVCEdvU4Qw14sgtL
	6/Hib7hdr+o6sGN3He1yZKrGq3Te7KvTdJCknG881xoAhfZbN7T/o6iHX2+G44w8GfIhHFOTarH
	aT2/MefU5lTDx46PB0ja5FSA+Xh7gmNokeWj3H5ubScNeWFmhmTwOJGv7VS2xPNkWjxiv9pgHWb
	ilb6Lm9qBFnkMcP+CgCX3rXpZ1H8u7SoZwR9nO1x6bzFLfpjnWlbebA+tj5gbPX+toHxB2Bjp+y
	VeE/rFciGa1hQjHbmFopl05WStkqpmdfQc5qb5e/w28kI=
X-Received: by 2002:a05:6512:3ca9:b0:5a1:3437:84ac with SMTP id 2adb3069b0e04-5a4172ee6b9mr13124133e87.31.1777271759755;
        Sun, 26 Apr 2026 23:35:59 -0700 (PDT)
Received: from foxbook (bfh75.neoplus.adsl.tpnet.pl. [83.28.45.75])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f652asm64457991fa.12.2026.04.26.23.35.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Apr 2026 23:35:58 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:35:53 +0200
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
Message-ID: <20260427083553.36ff4731.michal.pecio@gmail.com>
In-Reply-To: <20260413100545.71796c66.michal.pecio@gmail.com>
References: <20260331003806.212565-1-jp@jphein.com>
	<20260331003806.212565-3-jp@jphein.com>
	<CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com>
	<20260409100247.7cfb62d1.michal.pecio@gmail.com>
	<20260409221749.5e6bccab.michal.pecio@gmail.com>
	<c4275422-a9b4-4519-95f9-1163a7912709@linux.intel.com>
	<CAD5VvzCEV_XbHc_Gby7mFPBSgSebqKDKJf3VC8HNRrD+xWaTJg@mail.gmail.com>
	<20260413100545.71796c66.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/.OkknVOR4gOuo.3Taa06e1K"
X-Rspamd-Queue-Id: A16DD46DB98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	MIME_BAD_ATTACHMENT(1.60)[c:text/x-c++src];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-c++src];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-241223-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

--MP_/.OkknVOR4gOuo.3Taa06e1K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 13 Apr 2026 10:05:45 +0200, Michal Pecio wrote:
> Question: can you kill it by starting some video application to set
> the camera up, closing it and then running this loop?
> 
> while :; do v4l2-ctl -d /dev/video0 --stream-mmap --stream-count=1; done

Hi again,

Any chance you could try it? And also the attached test program:

cc -lusb-1.0 hammerint.c -o hammerint
sudo ./hammerint 1532 0e05 0 85

Initial arguments are VID:PID of the device, next is the number of
an interface containing some interrupt endpoint and then the endpoint
address (including 8_ if IN).

I tried with a variety of SuperSpeed devices (UVC, NICs, hubs) and this
reliably breaks ASMedia HCs within seconds. If the same is the case on
Intel then it's a bigger problem than just UVC.

The video streaming loop breaks even more controllers. I have some
general idea how the streaming case could be dealt with, but not so
much the interrupt one. Maybe rate limiting. I found that avoiding
Set TR Dequeue to Link TRBs reduces failure rate, but not to zero.

Long ago I also looked at the issued command sequences and I haven't
noticed obvious errors or spec violations. Looks like a HW bug.

Regards,
Michal

--MP_/.OkknVOR4gOuo.3Taa06e1K
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=hammerint.c

#include <stdio.h>
#include <stdlib.h>

#include <libusb-1.0/libusb.h>

void comp(struct libusb_transfer *t) {
	char c = t->status == LIBUSB_TRANSFER_CANCELLED ? '.' :
		t->status == LIBUSB_TRANSFER_COMPLETED ? ',' : '-';
	fputc(c, stdout);
	fflush(stdout);
}

int hammer(int vid, int pid, int ifc, int ep) {
	struct libusb_device_handle *d;
	struct libusb_transfer *t;
	char bufi[1024] = {0};
	char bufc[2];
	int r;

	r = libusb_init(NULL);
	t = libusb_alloc_transfer(0);
	if (r || !t)
		return 1;

	d = libusb_open_device_with_vid_pid(NULL, vid, pid);
	if (!d)
		return 2;

	libusb_detach_kernel_driver(d, ifc);
	r = libusb_claim_interface(d, ifc);
	if (r)
		return 3;

	libusb_fill_interrupt_transfer(t, d, ep, bufi, sizeof(bufi), comp, NULL, 0);

	for (;;) {
		/* GET_STATUS(DEVICE) */
		r = libusb_control_transfer(d, 0x80, 0, 0, 0, bufc, sizeof(bufc), 100);
		if (r != sizeof(bufc))
			return 4;

		r = libusb_submit_transfer(t);
		if (r)
			return 5;
		r = libusb_cancel_transfer(t);
		if (r)
			return 6;
		r = libusb_handle_events(NULL);
		if (r)
			return 7;
	}
}

int main (int argc, char **argv) {
	int vid, pid, ifc, ep;
	int r;

	if (argc != 5) {
		fprintf(stderr, "USAGE: %s vid pid ifc ep\n", argv[0]);
		return 1;
	}

	vid = strtol(argv[1], NULL, 16);
	pid = strtol(argv[2], NULL, 16);
	ifc = strtol(argv[3], NULL, 16);
	ep = strtol(argv[4], NULL, 16);

	r = hammer(vid, pid, ifc, ep);
	printf("%d\n", r);
}

--MP_/.OkknVOR4gOuo.3Taa06e1K--

