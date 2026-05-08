Return-Path: <stable+bounces-244725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJEBGM+v/WmlhgAAu9opvQ
	(envelope-from <stable+bounces-244725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:41:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CEF4F4582
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41863300B048
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA843A9015;
	Fri,  8 May 2026 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jce/helr"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DB1917CD
	for <stable@vger.kernel.org>; Fri,  8 May 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233291; cv=none; b=S1lHO7z3atLqtPt+R4+aCGO4R9uIvqbdOh6JnQIijc810ek5pJBmPypOZtnnffn1QtZLqzk5Zb4JSGoGQq8AqxiB3yc1XMJUIHmlEqKQ1/3tu/qE8UZkEAAu6K58a98Tn70haDTlss7IF7f9feCjNKTRhP7CCSfYOpzthN0C/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233291; c=relaxed/simple;
	bh=4jeS72mzcXiKWCM4qsplVp0Mj/GkUB+dWdgIWGbnu9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQ4I8iHf7MnJ++csxOt3b/1AFbKDFMUpGU06d16OJWBSeMJ7rATQEq0ADHYZyDsaGaT/VG9fQzJWa3s/6uXg2Ml+RqAmxtLq+RtvZmvmYsTt6cnrtUADXg2Z7XA9q/KOL57CoH9VQJh1SXJ2m/8fsJhQMXBysoV8GakR8ILMuBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jce/helr; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778233218;
	bh=4jeS72mzcXiKWCM4qsplVp0Mj/GkUB+dWdgIWGbnu9A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=jce/helrbjcIMssODjQAeGZdBT6aLJj/3n2pouP/vAiA2AZXVVl/UTXZ3HzReskyz
	 zr1xgCdbHJBnsdUqHzwHYuqezQCnF1l6SS8qVlj+EN1S6Bm2KOOyxJlbkt4d+OnVJS
	 ySRta1wGdIHGkuSivEn/UGBAt6k00/Il95G/T7C4=
X-QQ-mid: zesmtpip2t1778233211t34cdd25a
X-QQ-Originating-IP: FQcN7kuVy9bHc3lfSi+J4V6anHhvSK2RSUbQX2sz1PQ=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 May 2026 17:40:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17673215077824213955
EX-QQ-RecipientCnt: 11
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: dhowells@redhat.com,
	guanwentao@uniontech.com,
	horms@kernel.org,
	jaltman@auristor.com,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	marc.dionne@auristor.com,
	sashal@kernel.org,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: Re: [PATCH RFC 6.6] rxrpc: Fix potential UAF after skb_unshare() failure
Date: Fri,  8 May 2026 17:38:55 +0800
Message-Id: <20260508093855.1768013-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026050805-chill-winking-91d5@gregkh>
References: <2026050805-chill-winking-91d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MfVCm2vBFdjBo6pAmsKuo8BXpW5z11eUgpSL3EkfSvAB3bCQHl4mgZIY
	LxW4DZPH35nMbN2Ae2XMJNOjPx8BwgGu3QoiMWsaTgRiA6UTZqYkSo+wFNtgUf8Ht5g8L5c
	/egSB+9Ef27MsFlLz3stejFg52W6oSBUZziuY8GjwTSqyXZ93WWoIKEtlgMU40WdTbc+AvH
	ounZZWr+CGdFcQEdG/o0xaka9lFBW6altKc0YQzoJjmRVYe7aljehbz03RDlAzRYdYwNu1h
	37aqOPkedA24kxdlWoF8VgV4/N4KUBDLsrQY8ACJMkVBNp+xBnvwP1Q7w/L9wc8nBqPNdeE
	BD9QNs1m8OqbVc+tuuiPtx1k+L5PnD7uV/bcnBoAWDT0ZRZOOZRuzKIDYTgxSBbsVJyF0ZD
	NInLeYZ6ICj+pTanwmWiMXvGfTMx0V499ZbXuP2dHY+f4Yc0CmjYUhhukiCWYi70sgn4oAE
	dEnBDTVGcmOkCFNL6cwBOzvR/fTjHkxMkA8qJEtqqdCpRBPDRFU/qw8LlGi8IFjiA498hd9
	zmkuJg0daxjcD0N/yL/FNvj6D9UF8bg7VKTtvw9qWNxG6wG6ILEtvaQ/iVZEwsxmC2KMPPF
	wRIqf7enX9KSaHNQHMsLaZN39WAyTHd4ytxyY+8Vx038Ds8VX/WHzkr2dmb4pFcU81CgzFy
	9hNpbhiO57HE0jnG2mvh08dam5AsL4GnXGKfZLTfQjixLFWaMvv0pWWmoetYWZ+Ea3jcr9q
	nC46br87KG7zMyA8JhE/L7JJM6zRXND6IFW8UDDx1OS6aHacfZNKz99jOZa5dYH1aYsDBi5
	1nittBGJwI8z1Y3zng5nTIqKcs07iw09yhagekSpaUz+76BApcJKVg9lk/agayEWwuV9szL
	x/zQ6YKM0bPZ9YdLlfTjf6TfvcRELJvGybtp9PkgKWh095xjVWTHgPLdBdl3lCCI8ExzFSP
	BAGa2c91EPjxZTw0wsX/oN1BVLOI4QUjhVa43MtguphhhDTidLWijPx5Hu8PqIuzNiVUYeE
	8PmsnWxbVGOXlbhLLi+uwbvUXgjO0EpB7tHMGDrg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 81CEF4F4582
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244725-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

Hello, sashal change substituted rxrpc_skb_put_call_rx with rxrpc_skb_put_input
which introduced from commit 9e3cccd176b5e ("rxrpc: Fix CPU time starvation in
I/O thread"). It is hard to clean cherry-pick for 6.6, but possible for v6.12.y?
Maybe the solution is ask for the subsystem maintainer to decide...

BRs
Wentao Guan

