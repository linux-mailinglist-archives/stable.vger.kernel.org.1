Return-Path: <stable+bounces-230807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePrBAg4VyGksgwUAu9opvQ
	(envelope-from <stable+bounces-230807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:51:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F62334F769
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D2BE301DEC0
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B141302149;
	Sat, 28 Mar 2026 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liVl73Dd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46C12FF69;
	Sat, 28 Mar 2026 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774720267; cv=none; b=ha9nbegscTRuxKxg4l41Vg+C9/C5KM5EHPZBmxruzGfiF6sKZachO7j60frWtv1jc0KelEqtFnwxFAelmV6OKNPCUii04L1cO3k//Ozkn2CkWpL/ysyJqGkU7CRV1jzQkv0mj0SRNVwFQ2rIRfVyvoni3P/xaitfizlswnDvhzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774720267; c=relaxed/simple;
	bh=Lfa/H2VSyV2kIZ9S1jtBoE2PwbJXtQWrEwEFjGo0r/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIU0V48Z/iuAFFzw+E081WAQhlctHY+Dsqqn5u33Y8+prV4O1/sROxzrbKkNljHXHv1xiTjwShnT3+aCa+g88xvM1cauUjd7Zgwl0udwh4hvhYywLDU5AdBmzpGrAdbMFvcD2TqoP46dyQANwo4xSdfRWXKCrYCWkMT8QSWMNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liVl73Dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ABAC4CEF7;
	Sat, 28 Mar 2026 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774720266;
	bh=Lfa/H2VSyV2kIZ9S1jtBoE2PwbJXtQWrEwEFjGo0r/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liVl73DdPiG5av1OZtXrG5iyJdLEvA6mkuMEX/etx+kfr4gT6xI3kmjciOK9AV3AL
	 Qn7bGtOK8dzTVzpimzZyZy/0S+kCI3AInmM585KzSevkam9d63ccrG87l49fi9veQV
	 LKKeB7ss/q90tEt65vRariDAnBx+1M/Oi9J0XYJRmrIuRHiaUKy/bHOu3QWr+DGWGE
	 ZiYVNpqHDxaJvsHRM64frCfIQsgME8mxQyw81EmkKHLTi1ZiiGfBFdZqwdWp7tpRbX
	 6+ypTs9usmT5m4bBJsDj4WpQNDnLuXcSCJfiHcK/CFbnCcEe0yvpwgWF+YmZbDwpJs
	 rBI3lftOq0wGg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 6 . 0 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 2/2] Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param updates race
Date: Sat, 28 Mar 2026 10:51:04 -0700
Message-ID: <20260328175105.53481-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328173504.53129-1-sj@kernel.org>
References: 
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230807-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8F62334F769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 10:35:04 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.

All comments are same to that for DAMON_RECLAIM.  Please refer to
https://lore.kernel.org/20260328174852.53338-1-sj@kernel.org for my response.


Thanks,
SJ

[...]

