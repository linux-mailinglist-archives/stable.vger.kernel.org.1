Return-Path: <stable+bounces-254017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IzLIZfqEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:09:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3655C24AD
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACDA530039A5
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA15D3955D7;
	Sun, 24 May 2026 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6Fzm7Lz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432933955E0
	for <stable@vger.kernel.org>; Sun, 24 May 2026 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624596; cv=none; b=lMN1mPjHwrb8syKokgR4AOks2dslGZN44Rf/cQInAn5StuuKby6YK4TfQDaNPwkvzutFOch8bGCLmeXPH+rso5vmrZ03Wkz6VlUwmA1kBoDnX+GXo1ysWuB9FKXOm6iUF6p6tPfmEs1WwwdXV9uRby0Q96H5Xyb5syR11Dk+kK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624596; c=relaxed/simple;
	bh=iqdBp1SBe9s5B8xK7xryHGkN3EFOsiyJRhWFfYHWwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM7vqZrUp1uCyVjfc8rrI28zwNri3rOsjxtJQHI01El/v8S8HHJm44dCWwVch4aoyqL0q40GyMeee03xjIHnw3mGW2LI42xei13soQ2wS+YQNhyj4N8RHYu+Hjvn3SesFRfMsQUdK5+04rPDWNJ1A7WY/b8ENGHWEBZJLr+qPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6Fzm7Lz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC681F00A3C;
	Sun, 24 May 2026 12:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624592;
	bh=JzucgvGDuY3nnjHaY/HehPAaXtFO2Zl/ImV4s57IpW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I6Fzm7LzBNGdYt1QTBJ3uSSpybiWEKiJFjTUAdec+mZ3D3TCYBYrv4nwbEHt5MilD
	 s8QUeC8kxvcS1Ihii5msnBCmPwix43FvVk6e8cItREFormUZ3pU9RNPOg213SY6BWn
	 zXv3pE+L7hJsu+SFZ0vK6CWFHwA5RdV3m0BwowUXfYqwo/hWVOuqWrfZc9w0J4unn9
	 7aRNqtJKmo6znjXttpkLidutW22gmeO9W7+nubtHbp/cL/QVkv55FK88zmax+HGAMZ
	 ds/7bmS/ig/NJExz1rQIxMX8m8+6qzbfM1PiqYbL5ecicxd8l0uPIOagYl7/G/R9Qr
	 ETIDoKGxPCNig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	matthew.brost@intel.com,
	matthew.d.roper@intel.com,
	shuicheng.lin@intel.com
Subject: Re: [PATCH 6.12.y] drm/xe/hdcp: Add NULL check for media_gt in intel_hdcp_gsc_check_status()
Date: Sun, 24 May 2026 08:09:49 -0400
Message-ID: <20260524-stable-item008b-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522194134.126626-2-gustavo.sousa@intel.com>
References: <20260522194134.126626-2-gustavo.sousa@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254017-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4B3655C24AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

