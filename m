Return-Path: <stable+bounces-249821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFJQIdiYDWrKzwUAu9opvQ
	(envelope-from <stable+bounces-249821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:19:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF6558C3DA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A339301A2C6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1B5371063;
	Wed, 20 May 2026 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JW+W81+L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43BA370ADC;
	Wed, 20 May 2026 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275907; cv=none; b=A5jw6W6tsqyxwIidMMWS48BSSE92KwzUPQzhQSuMExt8DRuLlTsnWjjFW7BY+FJIifQcM3pk0dwv0RTMfs6PrP3DB1lL09F2FyMZILxT5lvD4dTRbQjUF0+1CqOTufngRF9z/KGRiFNsyep8lCn0Nr2wks01Bnpn7vf5Je++4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275907; c=relaxed/simple;
	bh=ggVGPJVk7kVGyp1NT77SRg+Wa7Rps5Xr4Ihm0W/M0Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tIDh3KP4l2rFXZFCO60ykqM7x1DfTJyqJ71mlj4zZqJbFwA6VB5aoxuWDGbx5/GyAMEPJ+FTod/C7GqOjEXsFdKVGq2/KxwDaf68Aa1PLILrjPOTzuDHNBki4erMm3SdBpHzG54nnR2m09PVv7pijLp+Kt432iWBIKYHDhugHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JW+W81+L; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779275906; x=1810811906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ggVGPJVk7kVGyp1NT77SRg+Wa7Rps5Xr4Ihm0W/M0Wc=;
  b=JW+W81+LbXuoO/d26VN1rau6wQkGJsQaRN9KHLYPycNwN4v63eBYbvEi
   V7Loa+BszHZZoksEzprq45+cwe/yXZl35wFA71n+nX2ugO6uqyvdhpkh1
   QE+t0PUMSk1sLgsiDHou127C+7Ks6DQYkEiJBCRLJpvuaOFfcmGWJ+gq6
   4cl29SrFOZvCjLG2uE8ZdAnZO0eTtFKk+3DVpvM9xDq/royUsQ1tiXPKh
   ajTiuEQzrtdNTITuzBM+PV9F0aobLi99aI72Pi5FQLMOv+RZvq9YTBvok
   gER9Coak27LiFq4Vif2h0Bqv4nO0DCPFMaEEHsRKhp3Z45ACMlFRGuibm
   A==;
X-CSE-ConnectionGUID: wpTJekSIQACG8Xoa6WmKOg==
X-CSE-MsgGUID: cJsyGzMCRzSkekfuoSk2qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83786545"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="83786545"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 04:18:25 -0700
X-CSE-ConnectionGUID: a9B0QlTOS3qaLKFjQMPI0g==
X-CSE-MsgGUID: Cm6BF7SBSPensCsRlW4Zfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="240397999"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 04:18:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Raymond Tan <raymond.tan@intel.com>,
	"Felipe Balbi (Intel)" <balbi@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/1] counter: intel-qep: Use devm_mutex_init()
Date: Wed, 20 May 2026 14:18:12 +0300
Message-ID: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249821-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: CCF6558C3DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

intel_qep_probe() calls mutex_init() but lacks the pairing
mutex_destroy() calls. Convert to devm_mutex_init() which handles
cleanup automatically.

Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder Peripheral")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/counter/intel-qep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index c49c178056f4..816586893517 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -414,7 +414,9 @@ static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	qep->dev = dev;
 	qep->regs = regs;
-	mutex_init(&qep->lock);
+	ret = devm_mutex_init(dev, &qep->lock);
+	if (ret)
+		return ret;
 
 	intel_qep_init(qep);
 	pci_set_drvdata(pci, qep);

base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
-- 
2.47.3


