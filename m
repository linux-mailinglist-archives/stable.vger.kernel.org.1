Return-Path: <stable+bounces-255026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FkxCNRUGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:44:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08C5F3E27
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B78CB3113F94
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63AC3EFD00;
	Thu, 28 May 2026 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNJL2v9h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1013B9937
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979076; cv=none; b=DFGADcBR+UjNYXKss+sPL+yfvuwh7bIvjqN3gaGOIJM2ojfyjbhYo72DGVGOFv52Cr/HUSGXyOG5vlYkMjjau67G0eMirmzL/IQukBwi3Rufe6FSV6IpQEzu4z2Z+lidaDL7hrQ2ip4EJ9VzZFa5vt0B6jrczzjGx5e0aKnw3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979076; c=relaxed/simple;
	bh=l2Tt48p6srvUIVxy+xt+rEVv4o4oXz307I+CM2p8V4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxMfDl/Rzr13t8917VCFCCyVBtdnCQY8Mf06gk/i1tQNElTjubNS8V/yjKJ04sVByfECOPk+KPyavpBGGX/b8J13ntFqKtbdojTka5uXLFqtAyOlXhW5HWTMIS3Xp+LUEERKh8ezwooe/s+qdaDYAQ6MS5ZfnzhC+/KpC0LQnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNJL2v9h; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-83538fcdda8so1046548b3a.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779979075; x=1780583875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2Tt48p6srvUIVxy+xt+rEVv4o4oXz307I+CM2p8V4E=;
        b=MNJL2v9hjwORiihAZuoeNgCSTx5k4CWSnDuIBxWs+PFk+mP0FgCGOBQwuQCW4jlmjD
         1uk98ZUe7gnjEjok9i5Zoqg+IyWTyY2cdtfaSPArP3dzzDg8PUpsX1Syjvnu3Fd2xvot
         UFOvLcVoA7yoZOQd5kz3LMY8REr9mC9O/cqiTQE0U5a/oXwZX2F2yyLt0HaCw7U3dbSr
         fv2NvJ00bXpPKENMyqngNSKF3mxVBC1glprhjWGd9jLzom00VlWEcFQ/iExlGuDyYWE+
         /QIae7R5z8cvgEu3jMCkIDs8BjIyPEuc3ZG1hAlDOTksQyrYTvxJ18HAXlN7cUA99zn4
         LREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779979075; x=1780583875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2Tt48p6srvUIVxy+xt+rEVv4o4oXz307I+CM2p8V4E=;
        b=gPsykHRkSTv5to5c5dzyd6tWInNnzBz0apdQJlk2YVzyfz7u1Hqx9ae93RRedb/Bel
         tfiqGFvk6dGSiuur54Bgu29RgDTYSSfBauM4ODo/eBoO0cS02A+xdzSMp9Qhz7RSAsT5
         nGCzUd2wY3EYXaJ5dXivb+GmpHLg1Yt59kkRj2diImj5KGpJoO4NUDN4hdJf6PIib+l9
         NlJwFSy6w96hSlcNPCYSXVX8Az5pC0ti/ssNpw3mA82IkzLaE54olqZn/J+/d5VALq6e
         HxFI4XOwt7ijrpJST4OIhuBqvftRyQ9iTtMXxgWXoMFvLAfEcHAbZBcPtByh88Cvek9o
         3FnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7GCvJZypW7zdNSeWjIU6qU1ZV9/gQl6OdByNUkFe3AiDWp/d0coX8f61geuaZwLWS6oj0lrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbm+dWj/KbMF77k9Yz711zTtqmiZmxZfP2ZMxldCQm1k3NupMv
	TV/Iy/8o8hkaEfDuRROJZxRrGPxsw8tXTBpLJJ5sH7Crmz0hRMjFLI67
X-Gm-Gg: Acq92OF5qfCkF79uvPH11fllXBxqVlgF1CE/FpUoRfZM+i8C+rT1YnFCoThjX61/baz
	/c5McCVYE5h1PXz9ChkKvxX8kxpkl2xf5z1DupBp9EkP6P88kWixZBXDwefIWsJcOAT/qzAjxoZ
	wsvoQcsDz9RBZ9yItC2X5RVTh2wcSYCQOnx1wVSWqhWgwaNO/jlwcOHBhlq240AFA1a/OXypIhb
	Hvoxu7+WXtUkj8br6mxh72mGD6Cg6Shu54yCPKALvLY8389SakKESsqp9OPgX581AmhQ5+zuN0B
	vym5VFWgp/5E/67vh9cOBnbSRo2y41AizI0ncZk3OP/Qj0ioFc5LUqhrQgwB5nXVX/UalFPS0SU
	QDPEJlQzp0xaOeXRSJYAHvcMlm81SOGC2cR0zCnmG3pwO6VGc0mDfhilbvc60kokzYX1cjHt9+1
	sT8q0Hr2e+pMWWoqoHjLBUP4h1BHw=
X-Received: by 2002:a05:6a21:b8a:b0:3a3:15e3:4e75 with SMTP id adf61e73a8af0-3b3f104d037mr2380395637.8.1779979074706;
        Thu, 28 May 2026 07:37:54 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70ba03fsm6058393b3a.33.2026.05.28.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:37:54 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	idryomov@gmail.com,
	Slava.Dubeyko@ibm.com,
	amarkuze@redhat.com
Subject: Re: [PATCH] ceph: fix OOB read in decode_lockers() via missing bounds check
Date: Thu, 28 May 2026 10:36:46 -0400
Message-ID: <20260528143646.860883-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <50dc5a7472fb2d6da4ebb71cc659b03a5df06747.camel@ibm.com>
References: <50dc5a7472fb2d6da4ebb71cc659b03a5df06747.camel@ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ibm.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-255026-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AE08C5F3E27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The follow-up patch titled:

"[PATCH v2] ceph: fix bare ceph_decode_8 OOB in decode_lockers()"

was intended as the continuation of this review thread and addresses
the additional bare decode site pointed out by Slava here:

*type = ceph_decode_8(p);

I accidentally sent it as a separate thread instead of a reply to this discussion.

Thanks,
Pavitra

