Return-Path: <stable+bounces-263450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G2BAKyZgMGoUSQUAu9opvQ
	(envelope-from <stable+bounces-263450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 22:27:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD2689D3F
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 22:27:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EIzD4Sm+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263450-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263450-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2127730480D0
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4B3B531A;
	Mon, 15 Jun 2026 20:26:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043583B42C3
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 20:26:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781555165; cv=none; b=uFYNhdhIAOGPXlsRTCVxjEGcLQOWHU3wWzogd5NwSyj7sT+XTu9ZQ3FiPkNO3cDrNeXslGL+SFllUy9o44AtyqlRnbF5PSjVZ5Y91a9uoU8WddBkI7Lm3L6fnPH2rCeJk7yqlX4oFiMUjPWfhurLa6AX4b2k3FTV9FtRAft3Ffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781555165; c=relaxed/simple;
	bh=L6uPFRUuvFSNX8q/A2FKlrgoQUCrS0/ehyc31oklwz8=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=A5IvxMSh+UvwVd7p7j27jh+LEYMZ1D1BT750BJAXqYkdIcvFFriQ+fGZd4kNIlOOGSHpORaH1C9jcaGzTVRA3pURDxbD3HDq3sh+WKGbzSv6krbpSpQDSDB2oViJhqsxJl3EPdfCKwrlvy3RTc+t+na/Alre+VzgUt7x1tn5Xfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIzD4Sm+; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b9318997so27488025e9.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781555162; x=1782159962; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6uPFRUuvFSNX8q/A2FKlrgoQUCrS0/ehyc31oklwz8=;
        b=EIzD4Sm+Nti8D8Y8MmBplmEw+gCAHiKgqeo17W9yCRX2zATihoshsTpp4wlw9O4dVV
         6b3Kco9nLvvTZYiA2WKvoZPaYrJlb4rWieAx8+nOSP797BIdeHtw63ZlvvhYBCAOnfQW
         MFO8vWep1WFEDcgxeca06v9v+uv6I6m1f3f9qo1lmJXfRnvcVgBz6r+z5HyZ6bYxYhAW
         2rzcvqBe6zpz/k02FFtHYxgtuYlCxp+8ot+YAmAoxp7Wns96ilwixTnyPbkRer/r8Umg
         C2djbomV+hGjNzX8P+oBp/VpCVANRXvICVIylXuXJ4SMbOBiNllpUnHhAywD6mSQSP9P
         jD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781555162; x=1782159962;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6uPFRUuvFSNX8q/A2FKlrgoQUCrS0/ehyc31oklwz8=;
        b=XfzTZygfAN4ZV9IqrlAU+h2z7OFHEhIlCmBjEujJpLbJtxWJQ3UOWmTUhhcB+4C5SM
         lWxbSFzkcSyYkJ4YgPAteT4FJ934qkakAQJoYi0b+Qrd7FWsPV/BbXQuq4e20x9l/7Qf
         oLaF1dEHpfKoYThFlQ2wLdNKccqhH9vhmxoC6UklDhBO0NWeZ8vzgJWW1/2upy32czd7
         JWRJif1IFDnjx62N3grsOD1iuQP9aOiakimQvyVlDq0UmGu+6k8esXtrGBpVJUNDXEgb
         tPfTqpwum1rNn7fwth1iyPpGPkZvee9aV4juHb7bR82EyrFyRhwyXdFY9jo+CKUc6/SB
         kz0Q==
X-Gm-Message-State: AOJu0Yz709Cx25mF9uFR8rbf3b7hMiu0t1mvVsD1oq5vtkPQoJi7ZWhR
	74hUEZKCiqDyt8uJirZi760IQzcxjRa/fd+7Vg6+FxvYDQFc2eUTTysAay9Wp/Yd8ew=
X-Gm-Gg: Acq92OE+Z0m6HpvFBsllgSP7o+8O77raBUOxaEbC+Yea9BQa8OL2sSnClUACziQep63
	jLQWDYsTufSqeq94HgF41ImdRkObrNoDu7G29f11IKTmw3SEKVDWFATtNKdzPxBxUQmjqCWuFim
	sOv/XPE6bJ7TMgUrVku7RDPO6CwDSo8HfKKJQUzZiRGE12zU3CC57Qfxh61G0MHio1dAXRGPl9J
	H2FkN171PECv42kvgOWPSejKeURyyWGBOyn4IguMZQdlK5+4Z/j4YCYQ0zNRT06EqVxzp4h7Prq
	I4w+gGpM1jPdEm+eebKGq7TqHKPOxFodzhhzIziTst/ZeXzImsd2KXK+9BVvagnJlLmdNqU4Gms
	0oRsyo7dsv5Ne4ET8Natlwm0kw2XqTYRXRL3GQStcTcJqKBdtS5luwyxaPVePb4gicg1NmSWZfd
	pJSMWR+JNK3W/An83nJ+QiNtPbccMWMp060bDYDvZzqfih
X-Received: by 2002:a05:600c:5246:b0:490:a296:fdad with SMTP id 5b1f17b1804b1-4922011df3emr155761335e9.24.1781555162302;
        Mon, 15 Jun 2026 13:26:02 -0700 (PDT)
Received: from [127.0.0.1] ([154.81.235.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa51440sm18582815e9.9.2026.06.15.13.26.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:26:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: Garrison Michael <dorawolfe803@gmail.com>
To: stable@vger.kernel.org
Reply-To: garrisonmichaelces@gmail.com
Subject: Project Takeoffs
Message-ID: <4636515e-b146-60a1-8b6c-f2cf6038173b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:26:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263450-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dorawolfe803@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_EQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorawolfe803@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[garrisonmichaelces@gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BBD2689D3F

Hi,

At City Estimating, We provide precise takeoffs and cost estimates for=
 all trades, including Plumbing, Electrical, HVAC, Concrete, Drywall, =
Masonry, Steel, Earthwork, Roofing, Flooring, Painting, and Carpentry ETC.

Our estimates help contractors bid accurately, reduce waste, and maximize =
profitability. Want to see a sample of our work? Let=E2=80=99s connect!

Regards,
Garrison Michael
Marketing Executive
City Estimating, LLC

