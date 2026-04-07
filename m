Return-Path: <stable+bounces-233499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LCKOw6k1GmkwAcAu9opvQ
	(envelope-from <stable+bounces-233499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 08:28:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E993AA459
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 08:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555E630488CB
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 06:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE15386547;
	Tue,  7 Apr 2026 06:27:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C038553E
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543275; cv=none; b=eqPfgX7ChVuDnh6AqZ1Ik/wKvWmRs69kge4fWY5OV2rQLCRUrK+piWaWKu61Zpk213XytJD+Qa+FFutAM3qcg4HH8ymmajdCIwNPo7gk/wG7soqOKXKBYi0Nkv+VN3UeMXVRyNxmHJlQl+7akvV2wmY6c0MM0csx6MciaNQUEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543275; c=relaxed/simple;
	bh=hPjuMrsYaKsfJl9vhjdZBalaE0Arx0M1rCXOaSNOhjc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=igDdytqlxIj5bKOAlC8Gt2C92jFsbaRtH1YV8AYWR86MI2xh/WXoITq/oN9aJ5n1f7h3TRUsR+WuYAOFi/yUK07uGi2/m0M+6sOjOwtR5ms8xsTuZS1W7+33OpCVPm9Xf8YVx7baSIgBrkqhnurNm7ZWzZMz5KmIhQg/sRhaBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1775543262t439t25697
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.220.225.134])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6191075983948110156
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
	<stable@vger.kernel.org>
References: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com> <acvHIpPd8BL_wFFU@shell.armlinux.org.uk> <076401dcc17d$905c40b0$b114c210$@trustnetic.com> <acy5evlrUesbcB46@shell.armlinux.org.uk>
In-Reply-To: <acy5evlrUesbcB46@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: txgbe: fix RTNL assertion warning when remove module
Date: Tue, 7 Apr 2026 14:27:34 +0800
Message-ID: <096d01dcc657$9ee42b00$dcac8100$@trustnetic.com>
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
Thread-Index: AQJzBzpg8BZoKCpC0lQLuqOa6+34FQF9cQKNAr0WQJ0BAb3yubR8vYjA
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NNgSqAauJRa7LbVzZPSEoxSro/o48ZQITbVT2OrIcq8k/j+I1WJU+vny
	Uvs7ElYpADt49lt157MiRsRZrotDPluRVtixN6Yh69n4R6QV1vDGmyeo4Ybl5WOplT1PRK5
	N2Te7I213Yq77oOirdK4n6cMgea18i4AAnVfDfq6Em/IZaE6iw7VLOc2rezHl2EV5Jt/iQi
	mu4M85tzE8LzHxUXhP26m+q87zIhhXwVrXqlKO96EYKZOKJhssapxWfEW6FH1Ns4S8ARkhu
	jjiCSCP6P7U0i01kyfU505wrBD/Y7m07KR9+6TPylk390Bg5dtLqEJL7Vqv+LDZfHCXxlP5
	YA29g5xbnZqHIWj9dqvOn25Tm8Qx8lg1jdsFzsRaC37Ud8OGX1HtqcgO6FMIZ1ni1qilWPy
	M9n0xs0Mulp95I/BXmv6z563PIIHz1YOp+4nOXa2VoxXBAtoSFOrWrEQphOkQ/LDUtMEhF9
	PZQnAAD6RfSFEXBBWSIsc8JpFQonc20bAINy9eecItUa+XRJj4Cluy0QcmkTdHNyW6cwLKa
	X1jVu98kVlx1z6PV7M0lqb0Neny1H/5ee0zvcLXa/AUUEIfua7ddZZWgG2ffjDNMweQXEli
	bG3MzW1/36F7ORJMaB3xO2OQ3iW2V7yvm6k/SarsTHuhOAms7ue6gnRqCzKNf3qz4S1TYTL
	asD4oLP+fH/ezTBgZoLRPFURNnmJOK5BPdwLri6AeHjzhgQgDQxireS0SzvN9rYt10f9cdk
	uz7Se9NNpAWalzNecH0YSGuqES3Ew24Wo36dw0ixrXDid0TQIXc8o+QhEc7z//aFZJNxerG
	s1EJYT1/JGBtxEQZVVWtfMnUpbpH4CaPW7CSs8m4pCjxX/hj8Aruzjif2IZnlu67d2mjciB
	upDggQwPn9HobVxETl3RQyinF/eBbfEdFiDZIIhHLs0a7FhtlZbwsb4iP/YOnZd3E1K0ZJL
	8Xzb2U1utU4g5aFyTxeszRGXi/nwbGp3083tXsFd7atfQXZVHinWJX8E2hB/m87y3rXGw6U
	v/kPg+WIhRFj8sWXcouB0T1cnaqlvtDVPiaihlwUsaTXbSzBGWLXm0govKY7c=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233499-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.098];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62E993AA459
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 2:22 PM, Russell King (Oracle) wrote:
> On Wed, Apr 01, 2026 at 10:16:34AM +0800, Jiawen Wu wrote:
> > On Tue, Mar 31, 2026 9:08 PM, Russell King (Oracle) wrote:
> > > On Tue, Mar 31, 2026 at 03:11:07PM +0800, Jiawen Wu wrote:
> > > > For the copper NIC with external PHY, the driver called
> > > > phylink_connect_phy() during probe and phylink_disconnect_phy() during
> > > > remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> > > > upon module remove.
> > > >
> > > > To fix this, move the phylink connect/disconnect PHY to ndo_open/close.
> > >
> > > Wouldn't it be simpler to just wrap the phylink_disconnect_phy() in the
> > > remove function with rtnl_lock()..rtnl_unlock() ?
> >
> > This is also a solution. But I think it would be nice to unify with other drivers
> > that call the functions in ndo_open/close.
> 
> Both approaches are equally valid. Some network drivers attach the PHY
> at probe time (and thus can return -EPROBE_DEFER if the PHY is specified
> but not present). Others attach in .ndo_open which can only fail in this
> circumstance with no retry without userspace manually implementing that.
> 
> There are other advantages and disadvantages to each approach.

Hi,

So is it still recommended that add rtnl_lock()...rtnl_unlock() instead of moving it?



