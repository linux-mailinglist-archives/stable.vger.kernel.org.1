Return-Path: <stable+bounces-245007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Mq0I7ocAGq1DAEAu9opvQ
	(envelope-from <stable+bounces-245007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 07:50:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2DA502BCA
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 07:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425F7300F1A6
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 05:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BEA35A3B1;
	Sun, 10 May 2026 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NfTe331j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240742DCF61
	for <stable@vger.kernel.org>; Sun, 10 May 2026 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778392243; cv=none; b=n2AiezIE6VFxRKgpxLJWSWSFrPNL8WEJvDl/ayRh/Cgx8qEU/cYKO7K1N9QqVm6uK9k6eo50gi+NtdM7dHE7rOKPVaAOblSPqMIR5gX/GeSJgPgExU4ovRF6bZjx9F35PTavzttHzZQNIstRcIxuAkFJ4geBKq5b9SoDer8qcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778392243; c=relaxed/simple;
	bh=XL+vINExhFuMQTTP70V6I3aF4N0+NgyPBdsvLAORuQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VRyYFDXZlB9AqsK5el4fu7aqY59gjGHFvk+PgwUQiNxlQekgYcWvhSUPxwgMeHavjTvP155z7djRnqmdzihzmUcFxPTGifK2mQ57iSwaGgmEVHxS9bAPFjACV/up3IQKTZOvham4biCrUvwLWMwLApgom2RyxJTwdljJeZCNW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NfTe331j; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2baf7378ad0so18218095ad.0
        for <stable@vger.kernel.org>; Sat, 09 May 2026 22:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778392241; x=1778997041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzZRn2JWPQtIOhL+COPBbPzW8EvBz5JnXb+/L/c5we4=;
        b=NfTe331j3/0S8EF/GYhmVozvEoD65S7lkyOMaowt9XKA+1ZhQzJVINYpmFufZPMjyM
         I594OLTh3KEi04c/EzPKcoF+NAmU7CNWnGjpgH49AkRIQ3EIOVPZni6IWb06QG4fCm8u
         7lyxH0sQAUJro7CywGUEJ7HehUqBOBf+Fvx0QtA+dP3C3DVsR3hKZ/rSMlme+WyAK8mB
         v5XIZ27WyxgxWf8r4mXHGMqd86gt3xdz+u9HwHD2MQOTGKbzZ9TgrYvTLb9JMEhfiB1f
         sBHVOkgNLga+Traf3+XNXjUqMiBqUOS5hrNJpw+w/psncb6rXGvM+u8ueilFx0R+K7TV
         QoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778392241; x=1778997041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzZRn2JWPQtIOhL+COPBbPzW8EvBz5JnXb+/L/c5we4=;
        b=ZVW5sr1/alLPgUapw1BM8vnfgsRcKjN1s28SrwBtf0l4L/LrrfCcOB6BCtmoxO4wr7
         qlv4TK8sCYLBHNGhDhfAojW6yYsdoZllo9L1RG/ZNz/SR20mcZk6tt6A1+VwQf9FcJ5L
         OBC+aXscHimfv+xNAX+BzV04X9JPlhY/bSs9oWn7UZDt/rUQayMoTbLNv7n1GRJXU05b
         B6L/JBXOU6v+1rDYVuEFUvENm2lnDlU+HHgml3jtEvwY0AFuNLms/hu3Tyl2k14gQjS9
         kL0O98RFBgvp1TDKE0wwObqg56VzuG/+0MFqJHTs1P1iybxyBwQdKNkRS9RhMoCpuDEl
         Srgw==
X-Forwarded-Encrypted: i=1; AFNElJ+6ZoLL674mP3YxQLiTFImK8PJ/G18A7dO6xLAV3U/iPVmvWBWL+s7M+4DnlM86AE9uXHICVEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSMjXaa5tGEeytpUJgMdnmWQ1WlOCK4AZcsm3uvii23DuUBNC
	+piBQ7LhcFs/av8A8Hm4RP1xLdqCvNrbo+6AgEWrpMSyY+YYKHURoXZgF51zbkigO9NZJmSW8iF
	VWa4Ov6tp2k0mBdMm3ASgZZ/iEA==
X-Received: from pllj9.prod.google.com ([2002:a17:902:7589:b0:2b2:5092:b66e])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:13ce:b0:2bc:7d5d:e2b7 with SMTP id d9443c01a7336-2bc7d5de4ffmr45251655ad.36.1778392241199;
 Sat, 09 May 2026 22:50:41 -0700 (PDT)
Date: Sun, 10 May 2026 05:50:39 +0000
In-Reply-To: <20260509015927.agent5-0002@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260509015927.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510055039.793085-1-joonwonkang@google.com>
Subject: Re: [PATCH 6.18.y] mailbox: Fix NULL message support in mbox_send_message()
From: Joonwon Kang <joonwonkang@google.com>
To: sashal@kernel.org
Cc: dianders@chromium.org, jassisinghbrar@gmail.com, jonathanh@nvidia.com, 
	joonwonkang@google.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	stable@vger.kernel.org, sudeep.holla@arm.com, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6E2DA502BCA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,nvidia.com,google.com,vger.kernel.org,arm.com];
	TAGGED_FROM(0.00)[bounces-245007-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> On Thu, May 07, 2026 at 06:21:07AM +0000, Joonwon Kang wrote:
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index ff292b9e0be9..7a2baeca2ba4 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -361,7 +361,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
> >  	if (pchan->chan.rx_alloc)
> >  		handle = write_response(pchan);
> >
> > -	if (chan->active_req) {
> > +	if (chan->active_req != MBOX_NO_MSG) {
> >  		pcc_header = chan->active_req;
> >  		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
> >  			mbox_chan_txdone(chan, 0);
> 
> This pcc.c hunk does not apply on 6.18.y: commit 5378bdf6a611 ("mailbox/pcc:
> support mailbox management of the shared buffer") was reverted upstream by
> f82c3e62b6b8, and that revert is already queued in 6.18 as 2cafad617431.
> write_response() and the active_req-driven txdone path no longer exist in
> pcc_mbox_irq() on 6.18, so this hunk is both syntactically inapplicable and
> semantically unnecessary.
> 

Indeed. Thanks for letting me know of this. My local environment was quite
a bit behind the latest.

> Could you send a v2 omitting the pcc.c hunk? The other three hunks
> (mailbox.c, tegra-hsp.c, mailbox_controller.h) apply cleanly and I'm
> happy to queue those for 6.18.y.

Sure, I will send a new version.

Thanks,
Joonwon Kang

