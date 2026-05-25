Return-Path: <stable+bounces-254053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLGiMl2pE2ptEgcAu9opvQ
	(envelope-from <stable+bounces-254053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 03:43:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3461E5C53E4
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 03:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4AEB3007F46
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 01:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E53224AF7;
	Mon, 25 May 2026 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpS/Mfgk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212225785D
	for <stable@vger.kernel.org>; Mon, 25 May 2026 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673241; cv=pass; b=SIka62b8HxS5bf4UKp/PxgeaPKVMpCVC2Tcnk4Ebkg2fD4uDFLNSP93UehXeCnd3PCUhMNpEAsyDYC/bZ+8+mE99UWrdR1T7GPS3d51j0R51neCYOFJWGujYVYvpHUTx4ST5iZZSxSGHqlgOdvzu1ynSf9e3w0vIe6ygyP+Ltmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673241; c=relaxed/simple;
	bh=6UQYl6eyZKUqMGH6/peysjFpMQP0SkbcM7BEOOu9bXc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VGGFwa115N8ASuEsgzto5ngW2pMAHf+Sezmbtw4Y4d2jxdq38XgVkozBLQZisEIoO2AOW41NH/hiQQOnrD/mLusf3i/DBRUluMs9nl+UeerCNZphism1rY4KOfQZdmhVc53wP43QgqlBJdaXe/7zOKeiD1kfc8elyDRamcsTKuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpS/Mfgk; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dd73b7c757so4152054a34.0
        for <stable@vger.kernel.org>; Sun, 24 May 2026 18:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779673237; cv=none;
        d=google.com; s=arc-20240605;
        b=lwLrwZwAH2HHXd3xnNCMRT2VmvuTOF8gpsNfGCzrJghd3Mj3NXU3dycgl4Xt5/cbJ4
         7PqAAxUTSvXFjHtsb4xbEGMzbRTxlb+PN3eT+yvQ58hnpDp4G2N9HdBpLxjrE6yKIfH/
         lOIMut7DAsJh01m/XVrk16098xIUqk6dQbzFBMQopGI4ubHEU8EKdIQCEF8sBDTIRphp
         EUbEmZs4Smr5BbvFqMEiee1JCRuy+QYLDbGwA0th6FElP8b4L9vCIV3NINT3DS5lybmZ
         uRXTL60o+YqRwwa4RGIyje8c5OJY6Fx6Wy0kjuFwXyGAKjA0Y4niAaMEh8oUC1QBcHOC
         pI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=K4k2OI+VB/Cd/340XtOgFH11SKShimTJe8JRAHnx0M0=;
        fh=+/mwKDyi6MHnhghAZGfmjvXZO8ocpNytzumeyvsdpwQ=;
        b=TO5WQN/K97cg3Xz9AQzU5KeZtnlnREdO8mRnshr2Mh9MozVAuJvEUYEOJACyib7v+d
         wi6iT/NOeyt2jYNFnyhHgsEcO2pbmXgvqLaehZQa55ReqvAcOdsEqQXA40CPrg6oc0Va
         TE3+77LJIPfV87KUkQ0zMIvA3U4JEwEfoiO+T5yhsCU1EjvBJqRqBOWrjokGfFIgxmZB
         fmD/2d1wqOZH/zp5v+TLOi4T1suSQ5YxcR5U4bC9fWx9UTY/0B0hNCiHqo2GPlw3sgcv
         cRC8e2emkmviRCrsWnP335g4kSVSaQVn55QK2QENCnZRZWJtVznxKgbT/41T6ijwLxbF
         Znxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779673237; x=1780278037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K4k2OI+VB/Cd/340XtOgFH11SKShimTJe8JRAHnx0M0=;
        b=DpS/MfgkBuVxiEs/VnzZSTGWOSMSnolaOMHFLerAUAuSMdARikZzPg+oEHNwsUhWQG
         N1KMoA/Iz11KaCldtMjU+XO6QcYxuvzw2cssi71DEIqm7gCsM/JxPUhZ8VjHWtutCB6g
         uotJ9AFn/qKUSo0YIl163ah6lZ2TIqW9sgofgLqvdbUD+gHtPyoJ6rDvvnUqskOSdIpx
         1wT3WwbUclAtvGByeekZd1/CfWCTNlNl8qwVMiZiD829eQvJJoiHAF6Ljpx28tEQTcvx
         WiuUaEzW4Vf3tyG/gcU3kMjdhxlk4b50AgdYkdtN21OqSJ9GL8OT4eNjDGoyKYPknG48
         yWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673237; x=1780278037;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4k2OI+VB/Cd/340XtOgFH11SKShimTJe8JRAHnx0M0=;
        b=ESg0wQZm7l6hJPPdxIGT/TD78y2qyQkP1Z3RGU7pI+fRvFef6oS+JFBbC/HDq8BlT3
         O8LQj66unuwuSUDYW1iUwnmzCPNHtBoiPbYSOhYdmXOEvV3TGWsIwJoWdKtM0CgOMpdS
         ciuKQXtsQcl6CsnKHnuHXTo7yqxu/86XJtzb2NmbTQdn4P9thiUtKFZsRJYt6X8S/rcH
         LZrXnP4V6lMpakwZvgRT+hf+B35h9G9XHqSEf8fbpQqJKIta1dLAr4HYV8cgHreoc8Gr
         f5sS1c9PpE/871B7GrpQ0VASqkrDjJKkdBx6cLobIC+GCi5I08Y9RCkX6Z/EdJm/OAal
         I73Q==
X-Forwarded-Encrypted: i=1; AFNElJ8u4NM0BuptuduoRABwcHrpCm0ptuckP+3RI4h7jGe+uFyv/cgh6A+cun80ClvzjX/qBocwvvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySj9+f/mKC5EBlHZSBzhbjRdHQj9jJOVsELlNMSuhMZMkuFLOA
	lDpu6u1ej1QehhFkv2FcaYRvzaOS7xmK0EWniDmuFqPjH8ibiFSxTmS/Ayugovotri2ptYah3Cj
	43mHWcJNetNpzmRpxuaJeGnX3DRyneeQ=
X-Gm-Gg: Acq92OFEQ1aQUtvqZJItQ2YCTWCtJYzh67bPmzAD86nyOGn5Y6iYv1XHNqFobXVuu8o
	YoULkL8ZT3GrVOeBhlxx8agPqSeThIvlbcDFxFsOQnJA0bLjFPvFq19WkyzgL1dYWyV83dEaPim
	IvII4PW93oPw9PqWiQxQdSdP5nGoskopYRlAwxzPqeRRuqyGl/iCfQN0T6Seeo2xljK3MsNBNCR
	QwzQJMoR90w5w6BF8Vmh0mcqDJ0OKeu3sQW4O/rvFxVGdfP0YaPd+Tf/2l7opeFbLn1qCRQdfd0
	V25ZbtLBK5RhURnzkWkersNLvdN1ITuOYLXisF6O25A/SnE+Qvf+xJA6KKCaFnCctunwA6/R8N2
	xlhtW1MuD
X-Received: by 2002:a05:6830:349f:b0:7db:b5c9:2d87 with SMTP id
 46e09a7af769-7e5fee043cfmr7877198a34.11.1779673237501; Sun, 24 May 2026
 18:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adrian Korwel <adriank20047@gmail.com>
Date: Sun, 24 May 2026 20:40:25 -0500
X-Gm-Features: AVHnY4IEtPryaTDGKIZaZ8ti5SbwQ19IRaMf9WSH0deAGqTVlZnt5GnBAPEKZTg
Message-ID: <CADgB2mE=WX_PxArBp40WpmQ-qQpbuxDRRE0TRg7Be_zGyuRqig@mail.gmail.com>
Subject: [PATCH] usb: gadget: f_midi: cancel work before midi is freed
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, dave@stgolabs.net
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254053-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3461E5C53E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Adrian Korwel <adriank20047@gmail.com>

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

diff --git a/drivers/usb/gadget/function/f_midi.c
b/drivers/usb/gadget/function/f_midi.c
index 4d9e4bd700d8..864527bf900c 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -430,6 +430,8 @@ static void f_midi_disable(struct usb_function *f)
        usb_ep_disable(midi->in_ep);
        usb_ep_disable(midi->out_ep);

+       cancel_work_sync(&midi->work);
+
        /* release IN requests */
        while (kfifo_get(&midi->in_req_fifo, &req))
                free_ep_req(midi->in_ep, req);
-- 
2.43.0

