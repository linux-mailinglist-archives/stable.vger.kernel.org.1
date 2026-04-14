Return-Path: <stable+bounces-237724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AApFED7S3WkqjwkAu9opvQ
	(envelope-from <stable+bounces-237724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:35:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70783F5BD5
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0306301CCDA
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0BB2D248B;
	Tue, 14 Apr 2026 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Es0iXft5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0242AA9;
	Tue, 14 Apr 2026 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776144891; cv=none; b=bg7BNRrx8Kq+yW3SRUqyWT2pxv7+CqhpdGt8mIqWl8qV/feCuAmt8UXCXmfJivIitjBToMlMir0REeOobtwPTjvNJjreMraqqh3BC/GQb8IIgQQaEfV/fCys1KBbqcDZ0gFtc26jD4NFRzWF14khU+GDzw5QoyFEL5WK9F36yeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776144891; c=relaxed/simple;
	bh=00QV4wG5q+k4VaF5QPPLAeuFbELO7QKOtTtsQtHWIqY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RlzY1UvlvdoGau6H7DcC5Q8HyUfdJX2OfIdz/KoLzP50KT0xPFqzMIPla50kCsxXw2DTlKVvMn52of8xNqnjnok6iRRCwvOLCPjGgTUbbXXtKuyfqn9YEs7VFP9wOWHHKhgCIUlyxuf3ZcNIa+TgcXk1ky7dXAqSzop/S5EiOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Es0iXft5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27179C19425;
	Tue, 14 Apr 2026 05:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776144890;
	bh=00QV4wG5q+k4VaF5QPPLAeuFbELO7QKOtTtsQtHWIqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Es0iXft56IBKC5yKJtA44+umNVTx25yiv4hl5t0CxISjEOG7uvMNw7HiEZ+di0MP9
	 5OdD3cgmSqMfJSFCJCiHZqhA2rMMTZYFfWJBjBpGbKrJrQRh2ZyQGFGU/aRHSWagrK
	 HhG3F9EZKzrAD+v4NVIo05HynJyojm1yoVFUZHJg=
Date: Mon, 13 Apr 2026 22:34:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: tejas bharambe <tejas.bharambe@outlook.com>
Cc: "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "piaojun@huawei.com"
 <piaojun@huawei.com>, "mark@fasheh.com" <mark@fasheh.com>,
 "junxiao.bi@oracle.com" <junxiao.bi@oracle.com>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
 "jlbec@evilplan.org" <jlbec@evilplan.org>, "heming.zhao@suse.com"
 <heming.zhao@suse.com>, "gechangwei@live.cn" <gechangwei@live.cn>
Subject: Re: [to-be-updated]
 ocfs2-fix-use-after-free-in-ocfs2_fault-when-vm_fault_retry.patch removed
 from -mm tree
Message-Id: <20260413223444.aa4a3c6df45ed6bb18bac168@linux-foundation.org>
In-Reply-To: <JH0PR06MB66327896972223B31B527A1089242@JH0PR06MB6632.apcprd06.prod.outlook.com>
References: <20260411194328.0CEB1C2BCAF@smtp.kernel.org>
	<JH0PR06MB66327896972223B31B527A1089242@JH0PR06MB6632.apcprd06.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-237724-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,huawei.com,fasheh.com,oracle.com,linux.alibaba.com,evilplan.org,suse.com,live.cn];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid,outlook.com:email]
X-Rspamd-Queue-Id: B70783F5BD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 22:34:28 +0000 tejas bharambe <tejas.bharambe@outlook.com> wrote:

> Any action item on my end?

Nope!  I dropped v1, added v2.

