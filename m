Return-Path: <stable+bounces-254164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO9BG4lkFGoxNAcAu9opvQ
	(envelope-from <stable+bounces-254164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:02:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3835CC08E
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC95C3008D19
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3823F4118;
	Mon, 25 May 2026 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQDRGsFu"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7203F4115
	for <stable@vger.kernel.org>; Mon, 25 May 2026 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721325; cv=none; b=PeOJ9ri/B5ofhCZoJ8ldhFT0YUHROF93tbP/jf4l4OLBwidzSXilZQZFNuQ+1mipBHS9qFokpnyqrdu+wN1CL8x80A2lYrqrxs8hHctXPsy5Bl1KAge625TnpGPrtRMDMU87gcyYLw2ZKuBtcOotRNBE8dvgERSqzOS4l7CFKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721325; c=relaxed/simple;
	bh=U2wSD17q1Tc2IUTCuRB46hxgyUdkv1T/mSiaZjdQbyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyQgYfaJWxqrLQkAgKI5CowEjeJOl2DjNsVxvOIeX2GQCyerm4Jns7KsnEe6iWPLf0Wp9YOg58X0DFiWdgzO2zhmZse9QCaYv3Cb5sbLX/+t1bjgKQHNEkpXeJw7jHXE2osRYdL0Q1ewmnuARVZbyapnxoA8wX2vM458QYBN+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQDRGsFu; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4856128f670so2006403b6e.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779721323; x=1780326123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4o3etUmMc83jKXzjzz8NI/vuwQndsejxWjbjMzrTj0=;
        b=OQDRGsFujslUerswpML+vbKMpWoiYW9KX40O1i9kFJ6Q1K0InBAiaYHyjNCrmQebdw
         WAJboDIyet/JFqZNohveyr8Ieh1yvUKOtaNK6v1g/JAWchyPem8bTQo3vrEisShfc5J5
         Qo6s5K5CWkhg8nyp7fHaDzrCDXA1zVOBCX8blRfOgPrfGHDosaEWZsrrAv3CkghDH+Io
         XYuCq+vUpEwKZilQVXlETbbHCkofU4G3R5aMeyi4TFSU7crvVr5SSsRJrLCl+eHrYHuB
         9OwZh+HW8XdOmGtVr9/W0peovoj33rYHD4tQSK/TYjFF4wxspU4RNUuTwyEmdHyJJ4ES
         Yivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779721323; x=1780326123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4o3etUmMc83jKXzjzz8NI/vuwQndsejxWjbjMzrTj0=;
        b=klmEp1YVfi4bSD/S7/kt9Lbs90TzivunAQlms4vdITFBHrOJBPRcXj+B0AEM0SmLjT
         i8aFnf64VZ/IICr8At2WWgoWSiZcTCBSL39txx2Kn8zGyW2JrChBJCscSv2NjxyOIobt
         fVcRv4wn+JsaqD6fhjL9l2X+ywSGeg4m01zUyJReJ6E2jJHishfrejxkkLu/rrPo39BW
         HZ4r3zRocPzlAZOEgyPHBB3cPjNlOrwvcpP54rVwFLlOg6CaX6PZn3f4TJdmVhp7E1gv
         AsBq6tT+CNdUwXVF03GbAwVPr22fa9n/r2HYTXD5uJluFdFrET79OV9fcEzh/l31HPPO
         AQWw==
X-Forwarded-Encrypted: i=1; AFNElJ/SijGrOvZEhi6ANjhepFDaPVxo6OG/qZ+i8yX2IQFRdYJY4oncnRcv9IluFvSiK/1gx/W50uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsocQA2rH90uio0dJtusN2IHkQQF5BsDpl54l37JQJyCE6DOUt
	zD5KTRZIbAZVz1ZSbDyKX/jLHJ6ekxiY68GHIU7emz0lPPVm11Plzln0
X-Gm-Gg: Acq92OGCfwByImW05k4plm+ENACap83FWG3UOgG6cSDgMwQiPzA3iV1VoyV2JRcLAkZ
	MD8B7NA4h3avFRjeWlRLB55BacCuDfFH3QLkI/axED8CUwuEiG8p/r7TNLeIUnzvOBwxiz3E4iG
	UCEZ32ZGGHbKWgIb25GPo3HORJO6Q+LQug74U5kROz2LbNvcwgoNyF2htTsinENndBRiGqBLw2Y
	qE4Sm+l1kxR+R7IxxKC5WWqFC4JmkbAYsS/TvABWMEdwcgPEiKDkzwMPv0c9qsRbaqPqmkMLyZv
	KRGxfvVEADLO5D/0JCI7RYeuD48rSFv6CoFS5CZESDUWwM+dsds00nB3bREISnci9ahp7EOPdXf
	msRE7FE1DHQpLMNAzhkO51MkuGDqPIR9GqScf8EhPuv1L53pd/4IR357M94R5GU8+G0P59+YHsV
	rwryuepadlPdRFSGBMcfw1AI95spM/qUUKMJtDf6efAkyZWC6VDh9ElCq5h7/I4nyRstERo208w
	nLNqot9WwUQ8+SCaiHlp1t76AKIKlp0I6YDXBvrM85MI14Qxv8GdQ9LOg==
X-Received: by 2002:a9d:60f9:0:b0:7e6:50dc:650f with SMTP id 46e09a7af769-7e650dc6933mr686769a34.23.1779721323019;
        Mon, 25 May 2026 08:02:03 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm7353920a34.0.2026.05.25.08.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:02:02 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	dave@stgolabs.net,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH] usb: gadget: f_midi: cancel work before midi is freed
Date: Mon, 25 May 2026 10:01:39 -0500
Message-ID: <20260525150139.3038-1-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026052509-shelter-caucus-92e5@gregkh>
References: <2026052509-shelter-caucus-92e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,stgolabs.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-254164-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DC3835CC08E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

f_midi_disable() disables the USB endpoints but does not cancel the
pending work item before returning. Since f_midi uses the system
high-priority workqueue (system_highpri_wq) rather than a dedicated
workqueue, there is no implicit draining when the function is unbound.

The work item f_midi_in_work can therefore be scheduled via
queue_work() from f_midi_complete() or f_midi_in_trigger() and execute
after f_midi_free() has run, resulting in a use-after-free when
f_midi_transmit() accesses midi->in_ep, midi->transmit_lock,
midi->in_req_fifo and midi->in_ports_array.

This was introduced in commit 8653d71ce376 ("usb/gadget: f_midi:
Replace tasklet with work") which converted from tasklet_hi_schedule()
to queue_work() but omitted the cancel_work_sync() call needed to
ensure the work is not in flight when the structure is freed. Tasklets
did not require explicit cancellation in this path; workqueues do.

Fix by calling cancel_work_sync() in f_midi_disable() after disabling
the endpoints, ensuring no work item referencing midi can run after
teardown begins.

Fixes: 8653d71ce376 ("usb/gadget: f_midi: Replace tasklet with work")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/f_midi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 4d9e4bd700d8..864527bf900c 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -430,6 +430,8 @@ static void f_midi_disable(struct usb_function *f)
 	usb_ep_disable(midi->in_ep);
 	usb_ep_disable(midi->out_ep);
 
+	cancel_work_sync(&midi->work);
+
 	/* release IN requests */
 	while (kfifo_get(&midi->in_req_fifo, &req))
 		free_ep_req(midi->in_ep, req);
-- 
2.43.0


