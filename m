Return-Path: <stable+bounces-244974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h49BL75f/2l65wAAu9opvQ
	(envelope-from <stable+bounces-244974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:24:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1561E50072B
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74990300F52A
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615B2D0610;
	Sat,  9 May 2026 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iexB8Vby"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A842050
	for <stable@vger.kernel.org>; Sat,  9 May 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778343866; cv=none; b=W4OPPOasKnZwk5I06fDe+DD45hXvCDgGxHLjKpgLSiwHOCGg0z3ak4MJ8IHLOdAKGTLDyZKN4M1hyOguQTaRb9Fbo1R+2Xx6Gr5khhCt0SeivknYkvDp/7Z3ZwJQpdPhwZD/8tGjpnYMVLxFCw7hSocR09uO8+P7+pkwzySJSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778343866; c=relaxed/simple;
	bh=fYE0zDLwjMTIC6bhSplP3CLYTTlFCELbif54OlV0diE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apUpkZNDn1ius0VhcJQUOlx6BY+DrJKeN6OndCLgS5BJjlBwmeczTfahujPqVbFs1jKtYX7cAorlzkY0d8HpbRYBTOHz96Q4Kx3Jd55HWNRaX108Nu/tRYN3+Q4Qlgo3vzjkqHtmfL3Hh15hFkkaQIGvHdgwcn33uJrj9ywSLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iexB8Vby; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dbcb45153cso209920a34.3
        for <stable@vger.kernel.org>; Sat, 09 May 2026 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778343864; x=1778948664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgw+L8XNnYGvME6rXbV9iC3YSJ8U6lhlX0++8uG2LmQ=;
        b=iexB8Vbylhyxg7/KHrMrX12AUoUD8i6aI2EUy8SZzdUDQl+OKca0QiXUXmFTbEyB7n
         on1AuYwxXMj3C4NREoTTZBc6IOSt5Gpeje+Nx6xb70LEGM/K1JT7krKJGw3HM6AMWzwF
         90W+930q21WsVu57FZhhZYqUONbplSE93zximlwATuLnP5jIquWAxlHp/3Ysrf/aY3w+
         lovfqKWJJPjKf7UDA4r0nUUOqC6EU5TR3r9BZeOpmtcV82n5A8qqdx46QvMSA9UdbILM
         JgWVTIwxYXYhU9TS2SB5ex5xeVCH+OzPwZUc3gNILjUpFjEbfBZfFIa522iCDufmrtPZ
         ZS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778343864; x=1778948664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgw+L8XNnYGvME6rXbV9iC3YSJ8U6lhlX0++8uG2LmQ=;
        b=OhPEQPrNG9IyTLOi24mS64tlTBfJqSpvGpPXtk8FzlklovnmSUAtVLfvX6sFL+ZvRF
         yZzbzCyPy3Y4KTvNLiEJ50dc6gxJwIUFoPkCQir7NP06OdGtmgm9rNC83i0c/yzaN8Qd
         vKPxVef9kVFI4IDdGUIEL0UFUSJVoRjKDfnFA+7zNxpbQTXcgIe/Ij0rQ22IiWX11HQf
         sgpgPpeT2hYokGxxmF9yVAnHRN06XmjYKyZB5hxcdM6d1O74txGohl2nOcUhMmYCxbnZ
         HlancoqfNQnJX2KIdUMvrlwgLfusm2u7K2jEHYHJZzyWtf5wZGv5M2zog9OoD6kh/SMP
         ptFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pCL3Z/SsI4DzV9q5dQq2zbuFEmvi3dV32rmaI4r/TJyySr5G4fqtBhWn+LQ886JuBGAW96vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpPuWWneBOC3vhWt1HYJ2c2rmDZfJ7vanzAifBe7T0BfovVfm
	3XZffD88RUxt2P65PxtqNvKUb5ggCr8r8P+rajgFFMjCb0ZjduXWDJfM
X-Gm-Gg: Acq92OHm3/PdqsiSXBWbdo+mbYpQXjwlfbahawT5gUqEuindasGVsrMPQehRE11SnNs
	r6maQuapDLzAqqAaiiMk8PFfE9G9FeODLmO9m24y5RUdvpHwQui3P+feRTCMxprGAV0RdMF7IOQ
	MInSSnAQrJjDj+BSxilezd90AmWbvJoK+OSEG0PEkbMv4MIgwyQs6T1QVa79RfAsYUmoOAumaZu
	RVRzya4vZl1IhBCC4dQ5B9a/mv9VUUEoxveXpdsYKGMpHMObisucTsGHsWHcb6wLYZWFLXCq9aX
	+EJWtdwnu7bhzkvcO7pvyW0nZ+D9yHA71tPcEwaQjKynVelpk/3OFghKnDItR9lO0xZzz/n7OBS
	91+WYoElnaF8Pw+ZDI5UKzuUagrjTGuUXgj+0rZtzaGsLkldPEM2E0q6UEUhj9sw2t+0eO6mLtN
	ln6ztZmyiY1R/ZOWwEpbJpaLxw9wybS3E7JtEL9nnFeQVuFbpIa/gUgMuhrlNT8ZpfRIHthh5rC
	lftctfBnqTbwoidwAqK5XCX
X-Received: by 2002:a05:6808:4f65:b0:47c:3d8d:1ff8 with SMTP id 5614622812f47-48045236867mr5560241b6e.7.1778343864317;
        Sat, 09 May 2026 09:24:24 -0700 (PDT)
Received: from localhost ([136.49.184.116])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986404sm16691775b6e.15.2026.05.09.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 09:24:23 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	mika.kahola@intel.com,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH 0/3] drm/i915/cx0: fix PLL enable failure handling on Meteor Lake
Date: Sat,  9 May 2026 11:24:04 -0500
Message-ID: <20260509162407.510539-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1561E50072B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,intel.com,ursulin.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244974-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

On Meteor Lake with a hybrid Intel/NVIDIA GPU setup, s2idle resume can
leave the CX0 PHY MSGBUS unresponsive. When this happens, the PLL
enable sequence silently fails: register writes via MSGBUS are dropped,
the PLL never locks, but the driver marks it as enabled and proceeds to
drive the pipe.

The root cause of the MSGBUS becoming unresponsive appears to be the
NVIDIA dGPU not participating in S0ix (addressed via the
NVreg_EnableS0ixPowerManagement module parameter). However, the i915
driver should handle PLL enable failures gracefully regardless of the
trigger.

This series:
  1. Fixes intel_cx0_pll_is_enabled() to check the hardware ACK bit,
     not just the driver-set REQUEST bit, so a PLL that failed to lock
     is correctly reported as disabled.
  2. Adds error propagation through the DPLL enable path: changes the
     .enable callback to return int, threads errors through
     _intel_enable_shared_dpll() and intel_dpll_enable(), and checks
     the result in hsw_crtc_enable() and ilk_pch_enable().
  3. Makes the CX0 PLL enable path return -ETIMEDOUT when the PHY
     fails to come out of reset or the PLL fails to lock.

Found on a Lenovo ThinkPad with Intel Ultra 7 155H and NVIDIA RTX 2000
Ada. Kernel traces before each crash:

  i915: Failed to bring PHY A to idle.
  i915: PHY A Read 0c70 failed after 3 retries.
  i915: Timeout waiting for DDI BUF A to get active
  i915: [CRTC:149:pipe A] flip_done timed out

Aaron Esau (3):
  drm/i915/cx0: check PLL ACK bit in intel_cx0_pll_is_enabled()
  drm/i915/dpll: add error propagation to DPLL enable path
  drm/i915/cx0: return errors from CX0 PLL enable on failure

 drivers/gpu/drm/i915/display/intel_cx0_phy.c  | 54 ++++++++----
 drivers/gpu/drm/i915/display/intel_cx0_phy.h  |  6 +-
 drivers/gpu/drm/i915/display/intel_display.c  | 10 ++-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 87 ++++++++++++++-----
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h |  2 +-
 .../gpu/drm/i915/display/intel_pch_display.c  |  7 +-
 6 files changed, 117 insertions(+), 49 deletions(-)

-- 
2.54.0


