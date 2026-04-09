Return-Path: <stable+bounces-235339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA3OEzZd12kCNAgAu9opvQ
	(envelope-from <stable+bounces-235339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:03:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D67483C76B1
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD2563018761
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A1038BF9C;
	Thu,  9 Apr 2026 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Niq4Qc+D"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2837C106
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721775; cv=none; b=iWiYB77reelYSCCHKNV8h67pjyKVsUM6a1JQz7R6MiAPbBRaQyOYWtkhfPxAfy6rz0iJksb/qMrP18iLeJWkfV5xQ3I6fQAmoAnpUbv53AoKp5jyQVb4Hnfqm9PVSqxzlSC2AA4pGSZDq8HeMQEgvLL7TKE9kalLgOdbsCMlakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721775; c=relaxed/simple;
	bh=0Ogc9JSBBGwGPjCCTbrNaU1DTQCu5wAABvOqgchMBC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjbxqVhhKJ8qrPPMBgqSUZEbFvDpvSC1SRH/Oq07PEX1H/NsAilVTpoUk0csw4bhKhAOLIeBZkDjW94+tQ0mNRU3H2Zr3voekgWoYdAym8mcn+v2Q3mRknTSJgAZsHqh0vc/BOQxwXYEIonOrvbDOeS0dVxJNExkzdusIv0UmVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Niq4Qc+D; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so294262f8f.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775721773; x=1776326573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s86D+DhGHsIGvz0sr+SSnyTaFHdgNLB1XeFc1X3fVU=;
        b=Niq4Qc+D2nv17obUxhZIeefeZtPwo6gAuQFFehxcFHqJdDW1xBIFJFpENtYwG8bwUB
         h8uCiRm1NfT3Qwo1GzLzvmV4LtW9uGWj0wVqd6pGs+mP7oRBxKLtjG8PJ8NoLXudfpEV
         39K4S0tNwbfwf7peK6prZL1JpvLc8tW4hu/TA2B+oc4QYvTIqb7WD0+22udNfDutAVYB
         fAT1cL+YXy8a2u4qcx3iRloMpwTSh5A8+20i6wBbUDE2+vcw0D95NmuaGa+aB13yIRNR
         /1xgQd8ls/9cihFMwf2jNT6aBZPx78A4WddH1t+g/d/w1Dk2MMF932Eb/ACtVR8Fqyvn
         /kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775721773; x=1776326573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9s86D+DhGHsIGvz0sr+SSnyTaFHdgNLB1XeFc1X3fVU=;
        b=O8M4LL62U+WwW9IYI8sbQ2OKb+fwDAr8l+PgON7Miy6J0fCjQ2MnZAofCSEHTglL3D
         3xfhYydX47bHFYdLtSHjmy6+LgB3TQd1XxTvoy1Z/Gx/4FLNeAJfy8onWVL2Y6Um6YvK
         MOI5flBFw333b6YX0DcJCKhSeOUHKIkeR7PedKCSb+R+Wwz2WlvdwAcFuUPfuzp0XuiD
         T7bw2g6xByA0JijN+2r/vNsl63oGV/JO+5prI55g0VjmzZY9Zi7GQ0xaEENPnnX5Q9DD
         2dbjj4QF8G3yrFmOGdz56bn9d00tNGmWHO8wxs+AShOWERhM28ISLA6lFSVmlhC6DRaN
         ZS+w==
X-Forwarded-Encrypted: i=1; AJvYcCWKEgR4GR1CJ7m0m7I7Vt/Wt9l4pL0DQLGGB9tVxxhf23bv/aME0nHrO6L0P+aBOttWKzOylt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPcy2aj/P/N8qGwDUfJSz0+DOfyDHotNCnCTEEd0Hrl1D5SGh
	7sNfldeGMdkCsmbTmY66/uEkp2XM3K1YrA/pF2XA82c1gIq8QZggUoDb
X-Gm-Gg: AeBDieuX1QbSIVlY9q3mFeeFhKbWuQBXqTe1n+m9IJreRxBkVIYwwHMtAMPSWWeOUhi
	pOYYqRKSq7eIMMWuUTHrEX40aOqgSktBELKfIMcYJAwZq6o0jKos4CyFAF3JsGen7ZloWZw1F8+
	WVP/X+cKZA+rB6E33W8BAqcusI56B17Dsje9UwdDhoo0rH/fX68+g7KbNyh0yQ+qOMb0/LoNXfm
	m1yIIujl1yX/nzNgEHEwmECHKpCONo3H7inhedYRBfmuzZDQh/+IZFA8peyBPiCA7nLzQXJVOxw
	MgprWzADRpKJZjAg+dPksr82bhJ9xX34GjfUtNFRCOWqLIpZnS527XOz24kX9lfClzn31xqLmuo
	mazDJlj78ChowuN4nlbxyvTIpeQBY/yaPEp7P/3EtzDLXs8c7B+wk3uGmuOJm7Mwbo/ZUJzRvjy
	ZCIwziDRRA3QSBr5033QNw8MY6F/6IMKlN
X-Received: by 2002:a5d:5889:0:b0:43b:47ee:4586 with SMTP id ffacd0b85a97d-43d292d34e1mr32435461f8f.29.1775721772525;
        Thu, 09 Apr 2026 01:02:52 -0700 (PDT)
Received: from foxbook (bfi53.neoplus.adsl.tpnet.pl. [83.28.46.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm63496077f8f.31.2026.04.09.01.02.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Apr 2026 01:02:52 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:02:47 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: JP Hein <jp@jphein.com>, Alan Stern <stern@rowland.harvard.edu>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede
 <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 2/3] media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for
 fragile firmware
Message-ID: <20260409100247.7cfb62d1.michal.pecio@gmail.com>
In-Reply-To: <CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com>
References: <20260331003806.212565-1-jp@jphein.com>
	<20260331003806.212565-3-jp@jphein.com>
	<CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235339-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jphein.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D67483C76B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 08:45:17 +0200, Ricardo Ribalda wrote:
> Hi JP
> 
> On Tue, 31 Mar 2026 at 02:38, JP Hein <jp@jphein.com> wrote:
> >
> > Some USB webcams have firmware that crashes when it receives rapid
> > consecutive UVC control transfers (SET_CUR). The Razer Kiyo Pro
> > (1532:0e05) is one such device -- after several hundred rapid
> > control changes over a few seconds, the device stops responding
> > entirely, triggering an xHCI stop-endpoint command timeout that
> > causes the host controller to be declared dead, disconnecting every
> > USB device on the bus.  
> 
> A usb device shall not be able crash the whole USB host. I believe
> that you already captured some logs and the USB guys are looking into
> it. I'd really like to hear what they have to say after reviewing
> them.

Sorry, I forgot about this bug. I will take a closer look at logs
later today.

I see that there is a case which crashes the host controller, but
without dynamic debug. It would be helpful if this can be reproduced
with debug enabled.

In the future, please also make sure that there are no unrelated
devices spamming dmesg, like "slot 17 ep 2" in those "stall" logs.
Please find this device and disconnect it or unbind its driver.

The initial cause of all that may really be the device getting
locked up for no good reason, but not 100% sure yet.

Regards,
Michal

