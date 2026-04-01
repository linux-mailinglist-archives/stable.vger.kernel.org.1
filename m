Return-Path: <stable+bounces-232648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKJ2HRqAzGn0TQYAu9opvQ
	(envelope-from <stable+bounces-232648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 04:16:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3823373B2C
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 04:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2930430370A8
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 02:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE12531714C;
	Wed,  1 Apr 2026 02:16:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15431354C
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009813; cv=none; b=bMEKZwZ9nAa26VXMd+Fh25plbO5baZEQMjfRH+jrRMAesKXYmWWNujkid/ohRahdWKOJAMbR+kUYMITthUfLvpY4cbgyHzD8SUH4oTZdhqtCVmlfMheTcmnH0lamPqFvzWxf+/AI2cniShiyukuLH16NfxjNfFhnBwUZTDkIW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009813; c=relaxed/simple;
	bh=o64+1RkjX8yy7bj4xpp8kQYTPeJethVN3dN34VjYyw8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FESNg58wRDWZya+pJOeltKrdQqJxtdiIIdaUI0geparlitganrVTkcVU/WTA8e1BKTw5Q5NzFXTqu1qWZf8XDAndISDXgWYu5aIaQMHK9Ra629+mr5Cu6W2tKECkrOIpaGRR4MNplKR2Fza9JgfkMlOuYcgTpiUFplgwPA1iouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1775009796t108t02985
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.227.224.139])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 10809986777126156013
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Abdun Nihaal'" <abdun.nihaal@gmail.com>,
	<stable@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Abdun Nihaal'" <abdun.nihaal@gmail.com>,
	<stable@vger.kernel.org>
References: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com> <acvHIpPd8BL_wFFU@shell.armlinux.org.uk>
In-Reply-To: <acvHIpPd8BL_wFFU@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: txgbe: fix RTNL assertion warning when remove module
Date: Wed, 1 Apr 2026 10:16:34 +0800
Message-ID: <076401dcc17d$905c40b0$b114c210$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJzBzpg8BZoKCpC0lQLuqOa6+34FQF9cQKNtJEALcA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NMB3uNxca02md6FurvmxYBph6NcWZMkH92KobpIWKQK3RKM4ueMMbRZJ
	Do6SGEDBlsIZ17far9qlMXNkPCXiYD3gjZLFGIwFHwbOqNoDF7jW52bXVEkl8fwi8HdL2Hy
	RQQvxPflPTo3Lno55wijFymerDc+DrWpItyaDs6c/5AMxEBgXxu/D1o5RsReDoVveNgwhHM
	AqJm2Er2cKPcgQfEPdlvB6l+2sx4AjHarAsNXt4IeKFMZQ+V1+D4du1e/P0Rs0XcEAZknEy
	TMxI+KEe8pxNGsKTkniE93NFIoAMhvFb8R3hqhtgDyIT1aVNuwazrW3TMkLd7EhQleJi7DJ
	IOROIRdtVaqO51k1JJ1QcSouz4vZL3Pcj6XntzbIoPjDJEppdb0R/E7wvQKaVw1uoFLOIp+
	LzD6ihY01ZE4/eJ/ocMaonJfl5+WJasSeGgdiywnYrWWMLMsd7uzhDQ/cxCEo8kZZUiq946
	j5ZEEKu1qYr6LZY0m+XIKfqiuBrjGm4Aw00KtmT/2DH8fVL6/DGjRYwDzKvS6G6lyoXsNDF
	234OJyviqCIAXr93fYG3uLUc/TfP0gv4USn5CQNqZDdKJO1ZytwiS5aAJXxULHI2SSn6+kM
	hyUjv+rBqx/vnsl3ix4bhfrmHBgsRHiYzLb5kqJI121Emlm9PO7NmRzw2E+iec5bKxE6zWw
	xGg93Uo3sBJH9e6av/pmNR+2jdnOuu9PdWE/cAlcS7sC1BRihKW3LobAIauCxlU2LnvHa6T
	ra75FgkrZCoIUrAbmXJv7iSmHiKIWSeV9FISKNp+7PQ3N/z13ElvBTbwQ3WJlveVTIpKXbw
	RrM2eGlOCUKNBmUv8U7fWRNHiRN0OFF7MJvhmFznuELYDYrrXd2M2sdI7ZzLiibL/WB5qp0
	+5uHInljmcgamynYR2VPwszSja7Z5hCzxPQCVd0M5LZo+8QJof6DC41QsR6LdFXAGKGDLAJ
	6AuV/rUvobxSuRj4JNKruRLpIEoXzgTLFVK5/2R592+FCpl30SzVFt+xSNEsSSfiIxBybV3
	emJEnxkIDeptjX0DtLz0BvUG/vapj/1jUbfzH6QA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232648-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.839];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,trustnetic.com:mid]
X-Rspamd-Queue-Id: F3823373B2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 9:08 PM, Russell King (Oracle) wrote:
> On Tue, Mar 31, 2026 at 03:11:07PM +0800, Jiawen Wu wrote:
> > For the copper NIC with external PHY, the driver called
> > phylink_connect_phy() during probe and phylink_disconnect_phy() during
> > remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> > upon module remove.
> >
> > To fix this, move the phylink connect/disconnect PHY to ndo_open/close.
> 
> Wouldn't it be simpler to just wrap the phylink_disconnect_phy() in the
> remove function with rtnl_lock()..rtnl_unlock() ?

This is also a solution. But I think it would be nice to unify with other drivers
that call the functions in ndo_open/close.


