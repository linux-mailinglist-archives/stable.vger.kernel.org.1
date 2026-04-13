Return-Path: <stable+bounces-236152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBFfKEIQ3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:48:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D8A3EE28E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 347AC3006B3C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB43D3314;
	Mon, 13 Apr 2026 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLOD5P3V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2D3C9EE8
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095156; cv=none; b=ccqezQ6EEbValjbEPbOmtdn6+Sbb8uUqzc2IPWeUNqHPSTTg/wM3nnehmIWPxriaQupnRgAj90tXRxa4BAprcCuOefnCf3BUOkwhE8BqweJIcGiZEu29hOJqjXGrVnbDeYVMQ0O7S75Xy9G/X8VG3DzBBprT00Mmx72RNGDdqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095156; c=relaxed/simple;
	bh=GWy6d9RgWQ7fDBTDJnAoX1uxrmCsDHbkEMIiaTJJCDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbRiIELtrobBLitDG+4vIQvlGIIVjDCCThxHHYe3gmYulghnDxIjDLT+J1F2CrIg1wNAHx0DCHGdxkyJ9GF1lshHW7NTqq8hQVCkGtP2XRm6vzmPAc/55GUuiGDtFmgTK0UmF7ClZ+IhkiXgGob7/FhGMnRebcn5hXqmcBsTaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLOD5P3V; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so2635784a91.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776095154; x=1776699954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Db3ejO0ow3std1Br9fC1HRbNkX5TOeSc7MEq0DFnkK8=;
        b=RLOD5P3V7uoWN8PTX4iwtBA25dCcKKDPkFghA+vfHVOxXqQsZC5kj2GC+p+0x6InoI
         ApULixspNxgMZvYvVEZ77Y2uOivZvFdvWP+3bPkvBEUTFKBDqOLfs3TIDbplGmB7+Ep3
         SVxaEtTKIM+OLCqvx9QCpUevTNmyn3FmvKG8mKfZiyL8WaNY34IgjnMdhr8Vw2WnZG4M
         PbRVXZAvs3x9yHmdD88oO0ikjdTsMGxqPLdNPfaZITfGZ6LyUqt5ahdSoCFFRnX43f68
         vLEH5VI3VCUlaPjQXR/cU9MSdYYy9+7Zelm8WF1NyRojIjJsx/qoWN8LvtMzRi8Wsrag
         KZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776095154; x=1776699954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db3ejO0ow3std1Br9fC1HRbNkX5TOeSc7MEq0DFnkK8=;
        b=sycUohjjs+4GBQfsHJnNxmHic2zr765OPYz0+xQZba6ydTTw/DcG4Fc7aPCb6rFgx9
         x8R5hvZpzlKYLQ1fbrTviDCJ0p34fdqyQ7KYz/5GnWkyZMiloOz63o5xWcjoPT1uLJk9
         yneIoE216nFgxJuA8lPCPEIQ4a93TphEnlamAyAbfhufNd5q7LAG6TSwE6uUOmWd5JF2
         GVJ6/ZF4ocmjjR8nRPwTBbU42JmKyo6oO7CS0v8t64hF9NC0oxLTKEQP4SI8XScPl2rL
         Bu72m6V0u3zFf0JPlEibtpQc8yR/n6nihY/eJSIZ62p8c47nBMO3lKUJM+hICeat+cj7
         Stug==
X-Forwarded-Encrypted: i=1; AFNElJ9nv0PNeflvtAOk5ALCMHi+XaJ+uap9Z9MhQ1TVKtJx66RMcCQ4CZOElyt8NNwjOoaGFJ01bJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUyhK8lEqJP+JTArLmoROm9OOTD27Jztzx/PLNyUWjy5WeH1M
	yaENDoTLtn2mwE65UokpqfqhSAcwnxTTFENCoef62AL5DA/oqp+GdT+1
X-Gm-Gg: AeBDietfG2I/KlDxDAbnu/6ZR+cHM2SaXbLxhAweFsHqN1dzrQyeGLDQEBnaxML7v75
	0/oUh/QIL9fcFoJvjiIgAtkYaAiXfYiLw96BSmqzY7HuBmBLqRadccewyq8aLzoRpSlktVUPOkE
	o3NUxGDrIdVZR19I/0OuRQn43WtmklAju5etQTQKOmVyna+wwr3YnboYdsy78rCTFGQl1rfThms
	s0UX+wiE5VhcCEh/EBM7cqxejbmb35y624MNnTwD5IYx15A8lC1CyVuDUtAtmmtShgIVdomWF8i
	nekI0BUNeTEw5Fsv+na5cOFQpEATAYocWJlt+ySST/bXicTUB4QI9q4QXw4YVvh7S46fj06o6W6
	DFfYUg9KxewdCOxNPBuytPd+exH/G+5uKVeZgcj0GkqDUWJa6bBa4TeRN0JfA9Zjd+6UIvBoSPz
	QfuCpmF3KTWHYeb2dyte71HA==
X-Received: by 2002:a17:90b:4d0e:b0:35b:9d3b:34cb with SMTP id 98e67ed59e1d1-35e42555edfmr14259995a91.8.1776095154233;
        Mon, 13 Apr 2026 08:45:54 -0700 (PDT)
Received: from ubuntu24.lan ([2602:ffe4:1:2113:9dfd:1ff:3726:3839])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c793488d824sm6318233a12.16.2026.04.13.08.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:45:53 -0700 (PDT)
From: Yiyang Chen <cyyzero16@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	"Dr . Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Yiyang Chen <cyyzero16@gmail.com>
Subject: [PATCH v3 0/2] taskstats: fix TGID dead-thread stat retention
Date: Mon, 13 Apr 2026 23:45:43 +0800
Message-ID: <cover.1776094300.git.cyyzero16@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,uni-hamburg.de,linux-foundation.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-236152-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyyzero16@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07D8A3EE28E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes a taskstats TGID aggregation bug where fields added in
the TGID query path were not preserved after thread exit, and adds a
kselftest covering the regression.

The first patch keeps the cached TGID aggregate used for dead threads in
step with the fields already accumulated for live threads, and also fixes
the final TGID exit notification emitted when group_dead is true.

The second patch adds a kselftest that verifies TGID CPU stats do not
regress after a worker thread exits and has been reaped.

---

Changes in v3:
- fix the helper comment in patch 1 to use per-task-foo(stats, tsk)
- add Acked-by tags to both patches
- Link to v2: <https://lore.kernel.org/all/cover.1776020234.git.cyyzero16@gmail.com/>

Changes in v2:
- add Fixes tags for the two commits that introduced the regression
- clarify that the regression affects both TGID queries and the final
  TGID exit notification
- add a kselftest that checks TGID CPU stats do not regress after
  thread exit
- Link to v1: <https://lore.kernel.org/all/6f4ed79d96c389a9a1d67d5ced96c6326eda82ae.1774552296.git.cyyzero16@gmail.com/>

-- 
2.43.0

