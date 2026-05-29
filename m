Return-Path: <stable+bounces-256572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDElLJlcGWoLvwgAu9opvQ
	(envelope-from <stable+bounces-256572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:30:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C445FFF45
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7054030515AD
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86533BFAF0;
	Fri, 29 May 2026 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HyL3lskK"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346843AC0FE;
	Fri, 29 May 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046758; cv=none; b=B0CTquz7YURNjKzuHmemSqLY4IdmDO71bAf+EOsk7sYxioFHEIjdXKB98F3KA+v8qHFsDTRLDy15R+TrhSClbymyaL/1iDowMhC8NeJLCyVWHNnF8puLwOaQb+uTke3353Ls/nGR+Z0V6UEL5BwbvsBQHNi/gWeFFwmQaEXcrVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046758; c=relaxed/simple;
	bh=whOnCD04XzN5dEKeBNOCPQ4ejB9dEQUjEpJ2VkWVcng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kd5D4LHS5AlEt8+inpCv/9pr2f6yg8uOU7aQcxTKJygO8/sM06yWoLSi4lIPNTJx6oLrrBarLPJ0qMNRdcRikh/aTHvDSZdXjknhQbGQ01xVp6titSWhl8rOhKjOcdl5QiVgKudU4aI9wjKA5qFrf1sx19v9xLbSb0MOLkqn+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HyL3lskK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B5A22247;
	Fri, 29 May 2026 02:25:47 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D4BF3F905;
	Fri, 29 May 2026 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780046752; bh=whOnCD04XzN5dEKeBNOCPQ4ejB9dEQUjEpJ2VkWVcng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyL3lskKyRvg6ritB3nqBC5fHzaOKf77CP2gBkaZ+ZWKGs3lieB7yH9Joq6V+b1xb
	 wZm8/4WB+h0UtoA2scNo8cHeoyOXam2df01vJ4wSuJ8QgMJ6BwqoiyCeMyQdhzds5g
	 NaVvsnMDiDhUUR9qSSYR0dO8halvM+DA2d77RePs=
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: alexander.shishkin@linux.intel.com,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	james.clark@linaro.org,
	mathieu.poirier@linaro.org,
	gregkh@linuxfoundation.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org,
	Mike Leach <mike.leach@arm.com>
Subject: Re: [PATCH] coresight: etb10: restore atomic_t for shared reading state
Date: Fri, 29 May 2026 10:25:40 +0100
Message-ID: <178004662060.671212.8394865025455902639.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528165201.319452-1-runyu.xiao@seu.edu.cn>
References: <20260528165201.319452-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-256572-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suzuki.poulose@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arm.com:email,arm.com:mid,arm.com:dkim]
X-Rspamd-Queue-Id: 34C445FFF45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 29 May 2026 00:52:01 +0800, Runyu Xiao wrote:
> The etb10 miscdevice uses drvdata->reading as a shared exclusivity gate
> for userspace buffer access. etb_open() claims that gate with
> local_cmpxchg(), and etb_release() clears it with local_set().
> 
> That gate is shared per-device state rather than CPU-local state. A
> running system can reach it whenever /dev/<etb> is opened, closed, and
> reopened by different tasks while the device remains registered, so the
> same drvdata->reading variable may be claimed on one CPU and later
> cleared on another.
> 
> [...]

Applied, thanks!

[1/1] coresight: etb10: restore atomic_t for shared reading state
      https://git.kernel.org/coresight/c/fa09f08ede3d

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

