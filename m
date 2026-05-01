Return-Path: <stable+bounces-242226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHtoO6n582mA9QEAu9opvQ
	(envelope-from <stable+bounces-242226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:54:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5274A9659
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C94323016FD2
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 00:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC70264A9D;
	Fri,  1 May 2026 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlJD0K60"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A21D88B4;
	Fri,  1 May 2026 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596800; cv=none; b=Kl4C9cGPjVYHlLKhGww8fg4C++ahpzUZAnjfadIrGpYE/ZzAFLIR5yGSZ6DlWw+luhCb8YsGwWv8bx4lArO6rl4OQB+PkBzbTcX7iwr53deMp5DANU/ywdzsoakmorT/tYma1D3VgwtnKuIaVyIDgdj3v7rnIShGbESyorg1Iic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596800; c=relaxed/simple;
	bh=KzQTclZuCoJfZ2MNb+MG5u6QR+eoQTmWjD0e6rKq0Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ai03xR65heEaCq9X3LkejpL9nShPaCHAvyHzdS7I1+Qfy+wP3jmrk7+hlUPkwmGlBgydiltVky8YFc6N/voHZmJFxP4o5MrahEhkjH5MIoYRUV1UYZSd27SVp8bPv+e/jAEioLrrMU9CQLtYd5rU1bhGvTTO9UApqb2B4iHJkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlJD0K60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA5EC2BCB3;
	Fri,  1 May 2026 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596799;
	bh=KzQTclZuCoJfZ2MNb+MG5u6QR+eoQTmWjD0e6rKq0Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlJD0K60kmdn1mNAXeHnhfZsjneL3nGCWYf7I/ZdXgzyzXQJiekK1lMzcW87+hydS
	 GoiCqTdA74XmXhhW+iC0cBGCE8BaWJiGzYNravm2WFtfEpI/MClfEujZDcqvC81R6O
	 Q3KmaylAZtD1v9RUDf1OAYzGj5piq+8YRmHjE68bqcsQMJAfuGV5lkir8KfKKn8E4H
	 EMBkRqcOK562uwtlI1/4uF7az0QV2TIBJ4Uvr07vNVOb+4NeFToXgKhU+uUH2H1eca
	 PgJ8cnlEAUM69P+ObisYRWX1WWuBmLzQ9NQj3ZWG1EsET19jcyHKf/dzvxZsJzyiua
	 xS+W7g+nCYBLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Robert Garcia <rob_garcia@163.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] f2fs: fix to detect potential corrupted nid in free_nid_list
Date: Thu, 30 Apr 2026 20:53:17 -0400
Message-ID: <20260430160000.item006-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430054510.2001015-1-rob_garcia@163.com>
References: <20260430054510.2001015-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F5274A9659
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-242226-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,163.com,lists.sourceforge.net,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 01:45:10PM +0800, Robert Garcia wrote:
> From: Chao Yu <chao@kernel.org>
>
> [ Upstream commit 8fc6056dcf79937c46c97fa4996cda65956437a9 ]
>
> As reported, on-disk footer.ino and footer.nid is the same and
> out-of-range, let's add sanity check on f2fs_alloc_nid() to detect
> any potential corruption in free_nid_list.

Thanks, queued for 6.6.y.

--
Thanks,
Sasha

