Return-Path: <stable+bounces-235485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBaQDpny12n6UwgAu9opvQ
	(envelope-from <stable+bounces-235485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:40:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2EE3CEC44
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686993010DB1
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68982E6116;
	Thu,  9 Apr 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ05Ean1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAF296BAF
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760020; cv=none; b=RDX3SImpUM0riNlSsOPubjCaSLRFYVb9dzz7hmGQiCqRyPEzArDq9eVe3lgMLlYvSe/BnJVPCrGy8DQtrt8FnAzUZMRIsBIUEkiUrIyQnTA9LDwZiJEjLqRIMbDr7sdQViW1LgqPPhbenwHHBrvgZmJTcyGo+gZUs683iqVXw+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760020; c=relaxed/simple;
	bh=thQzeiykELo/fwsdgBZVW/jDFIHzD6ZTl+5yJsqQizE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPwHEWBU8epDDy2Rc9ts2/0yZwkmlhXnUoRs9lRwAXFYWiFUuJP9xhqo4Pf5xxmMIQDV2R3wb5Up/0C7+jN2n0JyGIlKehkU/saOiIBA+/KzHAKZmLOuZ5bekRfbP3Rgm5I3er5BVQJaO5OnD96fJDLivZUndkohDpOf2BP6F4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ05Ean1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso806611f8f.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775760017; x=1776364817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pbe/Y5t71TqJtBY58+ahinO1W1322QS2uIOhop9klfQ=;
        b=HJ05Ean1kY0Zjm/WXUgOYgXd/f9sIjlOa28uTsSZjuXP136eD0KWwQUtrnRLZvn+0U
         959U8YqAkr4z43xYjb1i7SSpsYJ+Fqd0LFFACi0CKf2wYsEgBbPCXLMIHGfYe/WiK0a5
         TBzeGVQxhg695NvYdLuU6zaqXO59cF5alIgNajiIJYLX42Won6jRBkL+wjVQk+1iYIQ2
         IOtg011gmERCQWphmuuCXELp4gkIuJNKl6ZImFMEWekcXFliePOPZ2cBrXAj7saunJiZ
         Z1V+zvJA4LZPwk49kAOGKSt1i46TczdW1nWzbVjEGDAq122BTRZshCxOPhy9Z0R53USt
         +z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760017; x=1776364817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbe/Y5t71TqJtBY58+ahinO1W1322QS2uIOhop9klfQ=;
        b=EkxxpTtNglsB5rABsIUknQ1o17JhMJDmW0uI8FV9HVGNgnL1SqP4nB9RZoTY49vITI
         g9kH3VKmlmCaHoO2T+xqiHmhsdFOK/d82N0mmrnmdZ6rOcku2YuiddK2T+5uqW3VtCMv
         9o/fvSm1gdtpIH6DB4gGA6gPS8yyiRZjTZKPH9a4wcStrRlHIxX4SwXdkJcjs6Z/RJQr
         yft9USP+Z4KO97uAxZak/MRFzzXRaviyG96NSdoZO+ezb75ZAFTcFry1ZnuJmyIqVodZ
         TC5SbZp5A7TvMRcxo4CMBMehy8WCYxlzEXXbWPR8ZgU+IR83SFHCrloQgFEeR4FEJbv9
         8lYw==
X-Forwarded-Encrypted: i=1; AJvYcCU53aFjEBrgx4epVa2JNEV4zaHkpO/d5H6DrqFUGT1xKAaDTtzwL59Gb6kJnx5VYDJBZHG51NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb21FWphtx7zf2CSX4cpOicXjVf395nEzCeAqGxaVRR9BUQ2V+
	betdbHA2sSRivTDxpb52jAECq7DqEbtCifUrySiLUI+uREViA4XoPvw4
X-Gm-Gg: AeBDieuuT/ygMODWLuGOxPFwb2uHaD86uJi2gpjgS3KPURUpbgn5woeBu25Hpc31/jH
	xPSGCMuKu4WxuND0Q8Rv5Yt6lFGVQGBhyT5i1aSKPD96O8UifyQfj/ttIg59HIdhBI81KLxJfWM
	y45+R4PtKl6raDzX87FyMOYbWSt5JKD/5/9joVp1VCkhhtkzPyPIx2hzdVUBal8AEia5ZJsLBiR
	PQlcpq6rYXYYR8B0sQW0IHhX7sDjR6xvqMwNnwDbc68OwL2+954Ho8hpKuknvfNvKpC7krRiLJ2
	Jqgug186V87NFe252RRf1j5tq0Agf3bYMUZ8b2C/KyGb1kqR4l3cNuFDVK2KGMei7VFGdaCGXCH
	H6FAPAs9N/ihbDR39WKlMHr+a4yfLbIySbIrDbbDt48m3ZJB3F6fMNCuIsI4gkuUgM3b0rNxqAl
	ZrfAkYh8fYtl6ZrFop/Ea4kiD1fdx4bIV0NOon0+utS7ESlQ/F5v3dah1ZMg+liBKN8THW0WjBN
	vuKzUIWte6V
X-Received: by 2002:a5d:64e6:0:b0:43b:3d54:3154 with SMTP id ffacd0b85a97d-43d64254b01mr278430f8f.7.1775760017303;
        Thu, 09 Apr 2026 11:40:17 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5d88bsm560563f8f.37.2026.04.09.11.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:40:16 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: vburru@marvell.com,
	sedara@marvell.com,
	srasheed@marvell.com,
	sburla@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v2 0/2] octeon_ep_vf: fix napi_build_skb() NULL dereference
Date: Thu,  9 Apr 2026 19:40:07 +0100
Message-ID: <20260409184009.930359-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-235485-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B2EE3CEC44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

napi_build_skb() can return NULL on allocation failure. In
__octep_vf_oq_process_rx(), the result is used directly without a
NULL check in both the single-buffer and multi-fragment paths,
leading to a NULL pointer dereference.

Patch 1 introduces a helper to deduplicate the ring index advance
pattern, patch 2 adds the actual NULL checks.

---
v1 -> v2: split into refactor + fix per Simon Horman review.
v1: https://lore.kernel.org/netdev/Z-6w5kfCJoGhb30g@framework/

David Carlier (2):
  octeon_ep_vf: introduce octep_vf_oq_next_idx() helper
  octeon_ep_vf: add NULL check for napi_build_skb()

 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 47 ++++++++++++++-----
 1 file changed, 36 insertions(+), 11 deletions(-)

-- 
2.53.0


