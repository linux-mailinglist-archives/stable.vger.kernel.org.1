Return-Path: <stable+bounces-242231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Nb7NUoQ9Gmq+AEAu9opvQ
	(envelope-from <stable+bounces-242231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 04:30:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 727D34A9CFF
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 04:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A95230191A1
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 02:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C787C40DFBD;
	Fri,  1 May 2026 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="SVEGhQRI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7218FC97
	for <stable@vger.kernel.org>; Fri,  1 May 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777602628; cv=none; b=Y/OGgZH/yjMQwCNPwHVHMFJiumaL55OAjWK1681zOxvw1294d7cZ5+/+gS6He9wryX4g28INT12wTJpWdcuXcJZFa4aLYySW3vayDTZh74+EzAprTsyJlZOk8HXqplVhxstWVV0VP4Kmh8GgnX5CmpjLbQJGVPfkT8l+x3uW3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777602628; c=relaxed/simple;
	bh=CCVLitUCXLPN2FSJlQnFI3bLmon5s0+imal7KRJRIBc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=BfV7ZmrbnZfKPtj8eYulgQbsH4zWEznNTDgHF3gKpx6y0iN77Xk1cQscyzH96XDgEc0gm/CfHPPQCiShLvBSacFuVp9wZAIV1Su7+dhjpGA57ruQmfaU6HlhWs8NY8N6zzvfCfH/6Keoq7qFmNJ2rHhlVkDTWZWSfZZaYLAQ+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=SVEGhQRI; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so2053227eec.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 19:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777602626; x=1778207426; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLEL5vbDTAiRBXdyxorD7aRbERYA4NBYbmFsTRD9Fb0=;
        b=SVEGhQRIqtpriYNYJLgJFi1+yK8hfJKZ5khVDfuVSeI+WfcTylJ+P2W+mBRUCPhq4A
         WJZk/ZCeGJIteZyIGxzY5EpnQapG7G3JWGKnFrBfh++RwbI6ohO44Z/FKWHgOIWQvnTk
         xlH8Y9TGVgM5yb5rS1SGoMO8MZFfgsYZYU/oOewdM5PsYwtM/euJorskXKTwiHVaID3W
         7JI/IskMpKTYrdyTecsaeSJW6Ur1Y1kQuh1+bVj7GZdeplOBef09r3mtEqZ5oAkVmZZ4
         K3EFpKnUlQA0jy52WTQnstDYLT154dCb/3bKNbG1Fangfgi9M4hXEn7nVjVGR6a5kFQ3
         bsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777602626; x=1778207426;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLEL5vbDTAiRBXdyxorD7aRbERYA4NBYbmFsTRD9Fb0=;
        b=R1hJBet48Il8M/OBE8S+5sPKYIxxWReauSBb+QlsZLifmw6F7xAL2VC/RF2qWtOaCD
         hXg2ItxsjvyFEqEFY0lrnEIRSrrIPoWajJ/c83XOwkg40iKrvTRw+sdHygWDxzVWYW7K
         9VHTedDGIagaA2z3wELnjIuTr1xG6jHgz/DENEGQDBzPCSifVcKVpv+XgY+Lw/63Cqp2
         Fo49vwfP1ksoc/60hRPu5AzRrrkcdmpOg3DmW7yx4ls9uNuLfev0NxqjX3mPS56Ip8NA
         aq8cKLl0fIZoeN2kqRXrCGj7PwCoFQ0glTpYqv/EaV4F7u3e4483ABJpekRo0gmCW3Sn
         a7Cg==
X-Gm-Message-State: AOJu0Yye/EPKw7XRd4Rl7/yLOv/qus2CxTJanWYb28o7MKUc4zUsAXvx
	WBzMd/Vp4G0b9JeyPu4AXkGvCdkeZm1EW0OkUs5h0XIXdKBSSb6G3G+ASDzuJ/3Cr4I+e7ftlx/
	udAQ3
X-Gm-Gg: AeBDiesqTebViVpJ1DYWarTGTcqBtkDUXWidGuMQz47CafSv6QhK0MbTEXUdYThGpV+
	J5TmApizjKzoW6PsB4GjABPGnM6nfpiMvLnDCe5QDyJWOrtVtFQ1zGmIY5iaQl61DHAQ5Q+3igg
	vWS9/fZv2Ns9rVa4WxBrAp5bZud1XpQhrlacZ3QvLx27XbXT5eI++BpeahSKSEbwiWoYGkgnRjL
	99Jp/EfN6KjVb4Yt5SP03QFaVys5frK+lR4j372KL57V4SS09I4sPx5du5DPfH4vpztS4a7ra26
	Ljnov3AX9jk2e1KxH2svchjaHJGaD79e3w6JaRBI+yBUEKSsfedW14lDKsfQ06Hznynpxpc9zNw
	zyNdOSWp28W0XiF09G2JBNiAJyp/OW+RxkyfVirlwIZCiWfLMeo5dSHGtJQN95P/iCW5N8WXZ8H
	WWR2KlrfMc1K9mPp4y8ESjrunvQ6s=
X-Received: by 2002:a05:7300:7b95:b0:2be:a2d8:e9e3 with SMTP id 5a478bee46e88-2ed3e67dd57mr3148927eec.29.1777602626439;
        Thu, 30 Apr 2026 19:30:26 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm3822131eec.8.2026.04.30.19.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 19:30:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 258cf62a6dfde3c6a39d120a56a298f2ed6a8901
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 01 May 2026 02:30:25 -0000
Message-ID: <177760262535.770.5525529487086970378@997d03828cfd>
X-Rspamd-Queue-Id: 727D34A9CFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-242231-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,kernelci.org:dkim,kernelci.org:url,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/258cf62a6dfde3c6a39d120a56a298f2ed6a8901/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 258cf62a6dfde3c6a39d120a56a298f2ed6a8901
origin: maestro
test start time: 2026-04-30 10:07:26.380000+00:00

Builds:	   44 ✅    0 ❌    0 ⚠️
Boots: 	   59 ✅    0 ❌    0 ⚠️
Tests: 	 4663 ✅ 1613 ❌ 1468 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:69f33d5e800b539063e9e6cf
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:69f33b65800b539063e9b26e
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

