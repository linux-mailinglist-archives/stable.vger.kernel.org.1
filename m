Return-Path: <stable+bounces-249381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOmYCClnC2qnHAUAu9opvQ
	(envelope-from <stable+bounces-249381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:23:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAFF572D50
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 441E63044B81
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4393238A726;
	Mon, 18 May 2026 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKnmyjxf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED0390C8E;
	Mon, 18 May 2026 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132069; cv=none; b=mTptxe0tVEQN3KmvVHo9VyXxW6Iq22mCkKBjHnyLrvLnK6nRp3PDRUWaN114v7BbP/IGr818WA/iE2U1OrgdkMGNrgrARJ1BKJfuOiEmX5z7lrTaW3w3gnWGZx5lW94IyzyH3Mgp4i2YFDT2IBT0EIuwoJL1qEH4CT5nOQEyTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132069; c=relaxed/simple;
	bh=aeiV1jbhFJizB9KTTJsx+yZSv79v0v3ntU2VKmtFtkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSMbHTUNZBuPfEBIFzVB35R+RgiWoyFQZ0eec4IXCpRs//Znx5PtKklavIDEv36a+lcffsmviYrOaz/tZyV6vjHW8qCPk1SErzEACJas15vjuKED47PJ842+141eYYh4J0Gs3PH0Pr8P4giYoFAhDcgtleK8kMZqKe9bD4U8QFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKnmyjxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEDEC2BCC6;
	Mon, 18 May 2026 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132068;
	bh=aeiV1jbhFJizB9KTTJsx+yZSv79v0v3ntU2VKmtFtkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKnmyjxfX6lxKAq+XzWwi6+dZZjCVHp/tKjOBLyRTpMZ+Zf2g5zI0MOwOUVPF+Gd1
	 xyUe0/sC1dS5oYiL/vyhmDDoNlL99nAEAm6YkqSXD9z1/OCrf+rytz48SWMQny5k1b
	 xhuGNDQKPlEDSS5GHnjDFA+MGLyPPTqO5eIR8qDUcojBtOUax1llXcx/cOmgyetaZI
	 s7rziD2aAxEx/E2qq4NzApMVuBl4CPjcnJLZmzzqzx+KB8Oz5/5NS7skpRatqiuLVT
	 Cat8zk17rC3VzOjNYSiKrEqoOdO5LkK+BaRB/3mTM7BYTS8RNYhkYuiHG97OgrIeaw
	 JysJz4xlPzbPA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.1.y 1/2] smb: client: correctly handle ErrorContextData as a flexible array
Date: Mon, 18 May 2026 15:20:54 -0400
Message-ID: <20260518155236.reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_A2DDAC857112606A1A6068F56ACE3EAE2409@qq.com>
References: <tencent_A2DDAC857112606A1A6068F56ACE3EAE2409@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249381-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lixiang.com,talpey.com,microsoft.com,foxmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9FAFF572D50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026, Alva Lan wrote:
> From: Liang Jie <liangjie@lixiang.com>
>
> [ Upstream commit 215b7f9ecb8d7c14d56febdcdd246f3579c32aba ]

Queued for 6.1, thanks.

--
Thanks,
Sasha

