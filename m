Return-Path: <stable+bounces-235921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LeoBH+R3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989D3E7E49
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 136A3300B76B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F5E363C7A;
	Mon, 13 Apr 2026 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="NkvSfaqE"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80C1E7660
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062841; cv=none; b=k8zrxW6TTCX/rHD8BupnUprCkrOVLmzmxHXl8voUXXL9hzxYpUVJt9+CiHUSOE3bgIS8BZMGQ6Q6anIjz9bS5T+I7+KhzOul/hWx0ifj13iMeUOopXpTJg1pJaG71SIzhdP9ks2hoxgf+t/HyKhM/Lu5mL9xaTu9/t6TbTmmXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062841; c=relaxed/simple;
	bh=aP+8XF1oS79puFmiq6157hlrKAeTKgCuBrKDNCqaCQA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dNBt5UGyh7SrqxnrEyjMMNaXv7tqT+EW345bTTQsLfDoS/ltOKVaxlFvSIRvtRC9b2xbGawzktOsQk1e+eXnUfHRXB/eIn3MWNddvZ0yO+3XJc87hunESWODFhVd93eLjWJnHyGwS+htZ6ZE5AzhFDTC4uhEYz1Mt3w2YPflXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=NkvSfaqE; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 05D2A3F1C0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062839;
	bh=t0d/WjW6QT6SS7QbvWPCiMbQpf+vu3OFRVbP5b11obs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NkvSfaqEHXxAWqbearl2f/fozZNBYlyLiHb4+iEcEKmNja+iI26dnofIfQOQSaXfg
	 P9ybLu/OBBFIGTxS+BLDLKY4fcPAo4M14Mh2+PRuSxwXLFeu3Bai5m5DTa6ZGAq00B
	 OHKnSn133dURL20l+1Kkxg6JxrSvz+Qveu7X8e9VLDT8qGBEJs/4KxDIqKe/Ehj721
	 1tW7hCM/NQSzj23N0akrEOPu35tZVIZZj2L1iYFNSZs7lUSFU2IwcMU5jIYSSo8V9M
	 XRmBmZ+AQxzIdBbIvYjfBn2QOW/ypTrItDBxLxkaa9Z2MjA4k4G0oB81MMCXOlGuSL
	 2rXKLsK4EIPTfkyJ43D/43e398rxBGfOKLgl1D2e03KbAunlrWfMBLOvdVG0T47a7G
	 SNCscpSE9V1A4OckTeoBbQegjXF6vnGCLQO2T59TqBJ5DJHwpSUYkmoGfgk8Wh0ZrF
	 p1G93Nrm00a2wPLe8woYnM6BvUqXMY2ibedPHnRel7+QaGt2+BGKdhEuw0rATVgyxl
	 HcrCnztReXlN4t5b8e9wdlAJBUFczoRb496fachx1s5rx9d5jTog2PqzxD7utMwfa5
	 cZhbnJ2Vc/2zCyJfIMmnDFzcpYz/l/cxnZhGTokIv123f5chIOiCtp/rfCp/Tq3Spy
	 jJu7Zj92YDEB1ziWS2Vp3oMM=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358f058973fso4158083a91.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062837; x=1776667637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0d/WjW6QT6SS7QbvWPCiMbQpf+vu3OFRVbP5b11obs=;
        b=IfnRStD9rnZJIoH1od8kPaLMrfEQiBC/i6agsCgBqnNqj3eFiDeExzea/TLQZKdEYL
         d71OFyZMaGqaGzPe0fawMiKBP7K38qajcNfjfPs1wrACXSrEAZoKJLd9SG6fhalLkfxt
         RaKjsTEpRBoD9z/7p//UHUre+648Fl1BS1XQ9ojTdcC9vgie+aiP/Cft82cdU2JW5H2F
         z6dK1ZE/7SzSLpd8c/lAC4M2wwrkgL9qpXQGGCrGerfo0mventwqloy8gvlec2KuCB+F
         cN9YQUJGj+GqXuBEM3JLIJcfKqchjhS5UNEkj9Qd3NDj6G9nK1Y+xAbNUo1sbkD9lxEI
         AzVQ==
X-Gm-Message-State: AOJu0Yw9qQ97/11CKUOmaeCnRxdeGrv1Ei0jjdTf9o4ax6eMErKnxBwx
	5o529UfzZNtOlxOZ8b5bHXx7XKnxYcmO8PdiS6CFO/cNA07hc3NMpl6AE2VWZ9Omrpx5LqXKeo8
	qrKcFfT3PxvyvZtmdNYLDJP8NIia+jKBleNitQ6XtPuX+DU3m/EQ2SgQteRf31Mb9GJiEmdnWqC
	5QnAwm6Q==
X-Gm-Gg: AeBDievoVe46vxWJNfkM7eXXKZ9VbS2pNoCz/TRvryIzXOCbPRo+K0M5HsHQJCMowS4
	i6AMu+nrUf6hLdLkYzK3Xb2gZR4Mf+ofq3TfW6uu4a4SdRkrZaN3ndmy9vhh6jEDXr7ybNvNga+
	Z9M6LjWiXmuzGU0ymFVinloLB2tKQ0GBT7yac7BnwfVe7bk23t+q4LR6d6I7b3L8OwNrRLmxPJx
	XG9n5MkVxpEv2l3A/s4aCyC5kpfDQXTHUHs46FbetGNFQ4VhfTpWQDnDqGmPPH5sl1fP6agsbFi
	hjc0mV+3o/c3/If4uuwQU8M5KslgYCiW8R+VwplbOgFJzb9YWOVEFgChVflCueDktI0qRVYDL83
	KdZH2q8y0BDW4Pvvr6miG50Kpnp8=
X-Received: by 2002:a17:90a:2ca1:b0:35e:594e:59c2 with SMTP id 98e67ed59e1d1-35e594e8ac3mr2924221a91.12.1776062837039;
        Sun, 12 Apr 2026 23:47:17 -0700 (PDT)
X-Received: by 2002:a17:90a:2ca1:b0:35e:594e:59c2 with SMTP id 98e67ed59e1d1-35e594e8ac3mr2924212a91.12.1776062836630;
        Sun, 12 Apr 2026 23:47:16 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id 98e67ed59e1d1-35e34fd383dsm18415319a91.6.2026.04.12.23.47.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:16 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [Patch 0/11] apparmor: CrackArmor fixes for 5.15 and 5.10
Date: Sun, 12 Apr 2026 23:46:25 -0700
Message-ID: <20260413064712.1581137-1-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
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
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235921-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:mid]
X-Rspamd-Queue-Id: 7989D3E7E49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set applies to 5.10, and 5.15

The following is the Backport of the CrackArmor fix patch set to 5.15,
which also applies to cleanly to 5.10. There are 4 backported patches
in the set as outlined below. The clean picks are included in the
series because there are some ordering dependencies. They can be
cherry-picked instead of using the attached patches if so desired.

All patches have been annotated with the upstream commit and the
backported patches have an explanation of the conflict and patches
that introduced the conflict. The 5.15 set is similar to the 6.1 set
but does have additional conflicts (noted in patch 1, patch 8, and
patch 11), and an additional patch that needed backporting (patch 10).

everity explanation of each the fixes:

There is an LPE fixed in
  Patch [8/11] apparmor: fix unprivileged local user can do privileged policy management

An unprivileged user exploitable use after free in the apparmor fs
virtual file system is fixed in the two patches
  Patch [10/11] apparmor: fix race on rawdata dereference, and
  Patch [11/11] apparmor: fix race between freeing data and fs accessing it

The remaining patches are unprivileged user exploitable, via the LPE
fixed in patch 8, but also even with patch 8 applied still exploitable
on systems with LXD/Incus installed and setup so that unprivileged
users can launch containers.

patch 1:  Backport of 9063d7e2615f4a7ab321de6b520e23d370e58816
patch 2:   clean pick of upstream e38c55d9f834e5b848bfed0f5c586aaf45acb825
patch 3:   clean pick of upstream ab09264660f9de5d05d1ef4e225aa447c63a8747
patch 4:   clean pick of upstream 306039414932c80f8420695a24d4fe10c84ccfb2
patch 5:   clean pick of upstream 8756b68edae37ff546c02091989a4ceab3f20abd
patch 6:   clean pick of upstream d352873bbefa7eb39995239d0b44ccdf8aaa79a4
patch 7:   clean pick of upstream 5df0c44e8f5f619d3beb871207aded7c78414502
patch 8:  Backport of 6601e13e82841879406bf9f369032656f441a425
patch 9:   clean pick of upstream 39440b137546a3aa383cfdabc605fb73811b6093
patch 10: Backport of a0b7091c4de45a7325c8780e6934a894f92ac86b
patch 11: Backport of 8e135b8aee5a06c52a4347a5a6d51223c6f36ba3


