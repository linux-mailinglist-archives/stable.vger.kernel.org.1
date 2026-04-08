Return-Path: <stable+bounces-233831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPMmHb8z1mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:53:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DADD3BAF8F
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DF3C30811AE
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44E3BB9E6;
	Wed,  8 Apr 2026 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS1EBDYO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E423BB9E4
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645524; cv=none; b=fEql18dmGr0SSQJo4DQrcogffMA+lnIlua8o3JJbpK2NX1iDb/tG3tkjo45SP87z8iwN+2jRtid7Hoj9XJMDBBOEaXcooLXMtMXRXEuHXZSEMcSNuTFNgv1CKV9beov6yLoFUVIbPEBdzgOZquaYJoTZpDT64N6vvRKgxmW3FVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645524; c=relaxed/simple;
	bh=jPZKGiT6+978hroIzkv3xkAEAD82jfq72q0DpJyd3XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+ewtpSrRWJrFClN0xQ5MaRDT+FBZVKMkZrFwZfqPa4nyUk+073jRe9IhxNYi9pbNlvpyOgD43VT26eJv0Xibh5Zx81K8mWOBE8kppXNO5eJ9OdcWEkVXDBIB0nOrZQnUQUX4l/VBxLJx3h+HQWkcQbF4uKdirUuCwlC3ZrpWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS1EBDYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE17C19421;
	Wed,  8 Apr 2026 10:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775645524;
	bh=jPZKGiT6+978hroIzkv3xkAEAD82jfq72q0DpJyd3XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kS1EBDYO01Vu7gs0jNbtF/R/RmtP7O9ZUnZ7FoX0/g4F4zvbh3gHLCKyIUtsXay20
	 J9QUznKPxPB9pE8J2CA9TiNXfIwGrM93tP7R++0MZKZCnCLR+SLncKSroUdWHfdgz4
	 wiu8nye7h5tCvvfQPBXkSq2qdBKiibRFhcoa9U0kqTB77JqOiQ0E1xKlvJmjlQ+1ck
	 2/ljEwggbzFSPgQ6afU61q73IxzTPSqv/6t5qJ8n1irnvAKfdh+P1oRFQaWdvM7CU9
	 RXVPEn1X1Mrka1LGCS3Hk/dLjtHK0WlKralwGJtajwYgvke8OliTqEBee7B6eDf63z
	 mGGbCpVosoK8Q==
From: Sasha Levin <sashal@kernel.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.19.y] HID: appletb-kbd: add .resume method in PM
Date: Wed,  8 Apr 2026 06:52:02 -0400
Message-ID: <20260408105202.946364-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <MAUPR01MB11546B54A7BA6A80110B9984FB85AA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References: <MAUPR01MB11546B54A7BA6A80110B9984FB85AA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[live.com];
	TAGGED_FROM(0.00)[bounces-233831-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DADD3BAF8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Upon resuming from suspend, the Touch Bar driver was missing a resume
> method in order to restore the original mode the Touch Bar was on before
> suspending.

Queued for 6.19 and 6.18, thanks.

