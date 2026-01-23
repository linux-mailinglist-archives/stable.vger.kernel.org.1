Return-Path: <stable+bounces-211334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIT6BaYJc2mWrwAAu9opvQ
	(envelope-from <stable+bounces-211334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 06:39:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67082707CB
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 06:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD777300CC01
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 05:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA22C3783A8;
	Fri, 23 Jan 2026 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="p6FF3561"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA239CED3
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769146783; cv=none; b=iAwPKrkIzid4AZ28A4f+br0ix5e8xwxjbN90z3FGjTjadjWj0FhnyEX+Kz8XruXSjXQzm/iaE/LRk2UbbY9khtTxDHIuiDoMscN2KweAYEFhEF3+OyRB3KTdZzIEQKAwWmm6eOc3j7m1H+73u70NUsUo96M+Wg+9s24TPBSeXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769146783; c=relaxed/simple;
	bh=I8rYsPArjClMI0OlY9LdFMlzeRq2tpFxbh33gFcF2Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIDGbFzwF0nzV4v+mkgKWA0ZhDTe2V3UpJjt/uhvOMRsJ3q8SOZpITjK3FEtS800HKkRoO4PHnE+c5Xn4AjwQZm7s081+LV4fmq48ATcwItbWS1M5OL6bV95NzDYPy4V+YhZE/XTWrRaxmvr7VpEZTwmsHiMzuaMlT64o1+FFmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=p6FF3561; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 964E13FB53
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1769146767;
	bh=zLCXslpHHlmT4bEIPeZoanKUUqxnGQJncWC/wm2gT8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=p6FF3561yXGfz5fqeqQz2r4udX3FHAQUJXjNi7jt9JjUqkTwwT1KfEwklwzMs36Wx
	 LqrAR0m01vr7iwk7fgS9JednvyYJ+kbwS1arr49in5duzpBb5AnHnmuCJ1d/YeWM3l
	 cJ4Tuzj7vBy82hfSmdzE2xMk2k2tNvXHh0OWooul/qyGVZsgcvw3ZL0sYEI8+HAeL4
	 vmJw+MSbRTYfmT4rWq+mk6ZHw6OpmS10/uW0LhGBcMClkjlhpAhnzcdNP4MNLPUU2B
	 C20zXIuunk8sTD/7cOI5i0NRYhVP7M/q0LP6qGfbW++6YSiBb3thlo+eTW6eWxUp/v
	 f6Rueb74GcszESsYmqPPtVRPCVG8cJyPuez+NC+NNe0DxZvAxiNhP/+LNxIHZb1L87
	 dUX8/8QY4ItBbDFN383HP0o1JIqAtxyGHYSkTJmN5cP7iPiweXxEZv9mJoaLUoIumv
	 jmKxH3bSFprk9+vrDjsp3cHv2hZdAv+AakLSGI3ibfpz0BYe3NHkBl08x7NQUmFMlG
	 lgxIyAeLPycjdmOM9Dg2GQ/7bA2G22pBgsqhpyhPJ4aiRzn0sxyo8Mqe6Pq+EDdA/p
	 jw/Q5YzY7yglKmRWXAD7xd2aDkrdnBY0RHei8qgvdjmyNhEaeWUe6uf/B2OvKqHplI
	 p5KLi3k9zaFwMaZbOgMiDWhw=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a13cd9a784so16849525ad.2
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 21:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769146766; x=1769751566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zLCXslpHHlmT4bEIPeZoanKUUqxnGQJncWC/wm2gT8A=;
        b=WquVUr1QeNfjPvVnCmcVOZa5Z9oWeoZsj5rwyxQNhPSyugBl3yWMgoKxt+M9Szusig
         x2J1KS7NDE5pi3JN8k+pmt4HNRDUOy4BJC8rHSUPFBi2Fgz4Potv3FoY2YtDFaXRp5iK
         OxDmpLghQcFmn9yLkwa+Ul34kKitTBqH5Hkc9nhvcw+n49kVrvmhyQPPhTJkA8HbcdGy
         s4dkZXItTKNDiT/ZVKRNriALG/wraIZhjMkKJDeEvtMUn57hEAWmqsC1+BhGm9OWODCg
         1IC8s5oZvhUPhdffmOm9NhiGr0By1grLpoNchQmQRZtGeoBKYvwCNgEWdoUEGPGBcSxV
         fopw==
X-Forwarded-Encrypted: i=1; AJvYcCUqH5IewL6uXhbnR7orAuTrxD80tyWHFqpZk7YfezFmyAQOEFlbL3mM6a2KNF4RpD0BUVs43y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1giRxoE8IaUVu0qq9tNfAjyTeEdK6N6uGWwqENYEHBqBak5kc
	Bxw7gCvRfBcHFRG8SLWdLYFRv2OSaab9l4KKzeLHg5pUTLh6QoBfVt1VHTEd4cOfg+XCMj2DfVR
	HY6qnsYFLJECHxJXJr+6Jnzq48GiXrKOFpDYZHpT59bIlbLHDvD1hmFuEJ0FYu+6J8snT4x8kjw
	==
X-Gm-Gg: AZuq6aLEnZaXWLx4Vg8L280DTYgjbh3HLjhRkO7msSHblIw2ecEBoZdiOrxJLeDgyr6
	nNZtIJ7xA47kZY4Wk5K9d2YoPuQbMoPjmYSDTx/a4+78BFlrRXVEjLg0Mb6EGQ1LnK7kA+pXVFb
	WQPxXiYHGTZIGD9uw8aadp91cyyEdALmvjFH8BJCZCi9/wzyyjqQw7AR/H2tkVs8uLqSh0t67G3
	g3qrka8cYGSe2xk2oXGEwldMHo7vNE6Dpwwt4r3rLSuZAzvlxeL6NUZJIUycuElfNEslB7sqeps
	Y2P/dZjFU4V8SqT2d7rPfrQMGtEbQXIGqqeeruHhzJZA/cx01Xvhh6BPqyLHJJQdU4ZxkhKE3PK
	LTXGqWzuiv5935yHqB2ynzN5ipQ5BUXWFfm9xFneqHr7aqO11iU8=
X-Received: by 2002:a17:90b:5625:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-3536894d548mr1542088a91.21.1769146766172;
        Thu, 22 Jan 2026 21:39:26 -0800 (PST)
X-Received: by 2002:a17:90b:5625:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-3536894d548mr1542072a91.21.1769146765830;
        Thu, 22 Jan 2026 21:39:25 -0800 (PST)
Received: from Garunix (122-58-172-36-adsl.sparkbb.co.nz. [122.58.172.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536f25c4c5sm417930a91.6.2026.01.22.21.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 21:39:25 -0800 (PST)
From: Matthew Ruffell <matthew.ruffell@canonical.com>
To: mhklinux@outlook.com
Cc: DECUI@microsoft.com,
	bhelgaas@google.com,
	haiyangz@microsoft.com,
	jakeo@microsoft.com,
	kwilczynski@kernel.org,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	longli@microsoft.com,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	stable@vger.kernel.org,
	wei.liu@kernel.org
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config window
Date: Fri, 23 Jan 2026 18:39:09 +1300
Message-ID: <20260123053909.95584-1-matthew.ruffell@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211334-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.ruffell@canonical.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 67082707CB
X-Rspamd-Action: no action

Hi Michael,

> > I wonder if commit a41e0ab394e4 broke the initialization of screen_info in the
> > kdump kernel. Or perhaps there is now a rev-lock between the kernel with this
> > commit and a new version of the user space kexec command.

a41e0ab394e4 isn't a mainline commit. Can you please mention the commit subject
so I can have a read.

> > There's a parameter to the kexec() command that governs whether it uses the
> > kexec_file_load() system call or the kexec_load() system call.
> > I wonder if that parameter makes a difference in the problem described for this
> > patch.

Yes, it does indeed make a difference. I have been debugging this the past few
days, and my colleague Melissa noticed that the problem reproduces when secure
boot is disabled, but it does not reproduce when secure boot is enabled. 
Additionally, it reproduces on jammy, but not noble. It turns out that 
kexec-tools on jammy defaults to kexec_load() when secure boot is disabled,
and when enabled, it instead uses kexec_file_load(). On noble, it defaults to
first trying kexec_file_load() before falling back to kexec_load(), so the
issue does not reproduce.

> > >  	/*
> > >  	 * Set up a region of MMIO space to use for accessing configuration
> > > -	 * space.
> > > +	 * space. Use the high MMIO range to not conflict with the hyperv_drm
> > > +	 * driver (which normally gets MMIO from the low MMIO range) in the
> > > +	 * kdump kernel of a Gen2 VM, which fails to reserve the framebuffer
> > > +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base being
> > > +	 * zero in the kdump kernel.
> > >  	 */
> > > -	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
> > > +	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -1,
> > >  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
> > >  	if (ret)
> > >  		return ret;
> > > --

Thank you for the patch Dexuan.

This patch fixes the problem on Ubuntu 5.15, and 6.8 based kernels
booting V6 instance types on Azure with Gen 2 images.

Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

Thanks,
Matthew

