Return-Path: <stable+bounces-254022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOJgOqbqEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:10:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D33B05C24C4
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3693130041E2
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB4352C52;
	Sun, 24 May 2026 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbeX/Mg0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F950276
	for <stable@vger.kernel.org>; Sun, 24 May 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624613; cv=none; b=qn6sO2vw/1hzAAchfPKmlYwFynuDz4Z353ulWk59rnXuAHUoSqTEKuiMcFmKiXLR1SwQoAKBJv+tELQT/OLIinAoo0I6rCLTC380cCcZn3QyO1tlYsFxiW7APZqZm9qDkNVhLvoB1N4mUkUOdUgBVzt8uJP91zhrAGZNz8DtuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624613; c=relaxed/simple;
	bh=Hl9QoSe9XJTLFSgazDj1a8o5f+32uOFaFnhjfznZRGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUi/32otYLIHQa+MswdUaIMF6o5FJB6Bgo+OZ4hL9hjCyrByeZe0Jz3dAlgmCLyYpofOy1ircjjm1FOCmzfr8zgtHBd+nNHxI+qtAGQGnjYrPw06sDEMWd4PIli0UesjeeIGlF62Ie12cjg6Z2NT1RvLiZ43nhApinGxZTlHMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbeX/Mg0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615AF1F000E9;
	Sun, 24 May 2026 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624610;
	bh=J9BXVb3slJU1Eu9UJPNqqVJ94Fcdm0PgUFuFxcsE4Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gbeX/Mg0pOI/7ZLn/nra6aBfwin47sNKCVjFbAt7vMPtBVkeMuC1iSMqg4iOpQ8o0
	 yog5ByFYCC+7hsi8EjJaZPfJyWtReo75GLXOEay2k3Cz6W5/2xYYMRECHieq5p3b54
	 jT5gI9H/IZ7DFr105wU29Rq+7jnRmBlY10HZ6+16bl+0ssXltriCOo7wWsI3lrKYFH
	 lD+AAFH0NYdVIOgypH8Sig6vxDfR3iks+qUE3RwA/8g1nTUxZKOMZKyoSqI58J+OF3
	 993Bbn/tAxv6yvHPcYEEcWFdUH22RUVq+N8QwZRjFL10PNrGo8amHvuPWNYuA6cUlz
	 oV4DwUiUQfSIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Benjamin Block <bblock@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 6.6.y] s390/debug: Reject zero-length input before trimming a newline
Date: Sun, 24 May 2026 08:10:07 -0400
Message-ID: <20260524-stable-item013b-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521022834.38706-1-pengpeng@iscas.ac.cn>
References: <20260521022834.38706-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254022-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D33B05C24C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

