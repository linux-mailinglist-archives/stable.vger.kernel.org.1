Return-Path: <stable+bounces-233513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGqXIEu71GlRwwcAu9opvQ
	(envelope-from <stable+bounces-233513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:07:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD983AB18F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E823008A6D
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780503A381E;
	Tue,  7 Apr 2026 08:07:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207F211A09
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549254; cv=none; b=uQnxy0wl08LnBmEuSQKEo8Di5LB0gYnu6hsfkBQpG81FQ6NHY2/BKGLDJWNEdmK+pCbScr0p5sdzQcU5wvsELqMYVHifQh1ZsYCZLAChfjtsHeSxoo9U/Pe3FK0psB8o0Qb0PuQVLHr+nFuqOxil+2WIjS8sKmFbBnHHX1Ie29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549254; c=relaxed/simple;
	bh=Mb910JIaKwZe2patqm2uCUUaQgXoq+nhCRjppMWfnRM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZbB990IuVbguRf/tHYE/TQGXBV8tXbYuKPNnQjI+IAKBl44vFmkLday9o+KUhPl4xc5PDa4hOfLBaWa2s/eeou+5ZRh/rqGs+ZhLp0aduo9x4lXapKpcWLZgwQm9P71x4+zDcQi+WSgmRXVt/lZ6FHe7yYd/QgPZolxO03K+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1775549243t653t01181
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.220.225.134])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 11981075419421733400
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
References: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com> <acvHIpPd8BL_wFFU@shell.armlinux.org.uk> <076401dcc17d$905c40b0$b114c210$@trustnetic.com> <acy5evlrUesbcB46@shell.armlinux.org.uk> <096d01dcc657$9ee42b00$dcac8100$@trustnetic.com> <adS0_I_2HBH-gM19@shell.armlinux.org.uk>
In-Reply-To: <adS0_I_2HBH-gM19@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: txgbe: fix RTNL assertion warning when remove module
Date: Tue, 7 Apr 2026 16:07:22 +0800
Message-ID: <096e01dcc665$90354900$b09fdb00$@trustnetic.com>
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
Thread-Index: AQJzBzpg8BZoKCpC0lQLuqOa6+34FQF9cQKNAr0WQJ0BAb3yuQE9QT7jArzO0LK0XQmB0A==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MwVR+5AyjF6h5AUCYZAmDnMqVpVzc1DAmGn/hFz11OLT2k+2IrkL+nUv
	E3fT2QLTCn0R77FOUppVMcTt2i/IvtaFbcRC2fWGxuB0sy/GKlS2DriCoxXTwG3zXTG/c8P
	sKeMAxxnrMSi5e7PQWBw6woocmjw7R44Z9pTrS/RwvgkP0Jn3Wcf2pa2TuvLfqnf2Z8BO/5
	ZGDkGefIavbstAazjhaWmukvmJonxDlSIGDOmjtpltW02zCFwA9zf68H+9pSar7SVwhvc2+
	zGwT2CLhpKWIubPnuqGNFgfirBdyg2fpn/rQIK81ghGWHfY0cs1FuK6p3xL36eeBC0AHAYX
	Pyfztmwdg6jMfoOkhUSfkbf/7b/ZJlBThXHviN/MWbr6ZynEeOHHfFc0W8E5CwvdyRghZQa
	8d8mZrv1HBKTfq272AhJYuvzCbIC3cI53MAIl62sUfm/rZANMh7tGvkzCHKpnE3G5fU0SEU
	0z0xo1zBQ3HfO9xv1WDHPGOS8xJakmTHrOFlz5YLwAsFW5ITVqruP31uD3nk6nmNmzWECMM
	qrV5ZYhSh/IN+k6ydxDESdL546tRklp2yL/az2NdLVCoO4hKCkJfqQA3ThWAKiACaxSNRI0
	dXJtI90QA8pNdMCXwaDJneqCEXANLJxs51k+RX5o1V36ciIvoX4IX12UOw8+cNsd90m1cL/
	29BXmrQolPJvkHpA8OMqMUWmqnR4Xf25hsnRtwqlAW+ILFa2to6HCGbJfmgJfilkPvgOtdE
	q4d8aqnKsNxLstFQcST2jNf+dDbjfPE6xXsLIN9SJMAEnkWhOdjibGekOJViiIHQaS0JWEK
	+JlTL4ERu9jnESTRMYb7M4s9NEQf9hWiu26zhBINvcM9NFF6cQ2Z1YWubCwJC5NP91F7Yeu
	l5kncrrMt0L8AGx7sYreDFpZtmRsvJqJpxktZbozaTRwdAgpeZXCYr8TYwC7xtMvRN7Rhff
	L0knOKLvS+3WqPSikX+04qfw9HXpOJryFYHAcEandZgk+LUVGRXodRsW+XovsNcu0xcqlIN
	8gLzKKi2vxNB3tPfqQniGPU4yZuBVRYWnRP8zwgD394Lyc4iQCWBZu6icRY0yNMiKvzBJPH
	ZBJ8kwqJ9YhK9RfFklkN7ClGPyjm13MPu909/pIXP/aGVh72XoOS/o=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
	TAGGED_FROM(0.00)[bounces-233513-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.097];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid]
X-Rspamd-Queue-Id: 8CD983AB18F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 3:41 PM, Russell King (Oracle) wrote:
> On Tue, Apr 07, 2026 at 02:27:34PM +0800, Jiawen Wu wrote:
> > On Wed, Apr 1, 2026 2:22 PM, Russell King (Oracle) wrote:
> > > On Wed, Apr 01, 2026 at 10:16:34AM +0800, Jiawen Wu wrote:
> > > > On Tue, Mar 31, 2026 9:08 PM, Russell King (Oracle) wrote:
> > > > > On Tue, Mar 31, 2026 at 03:11:07PM +0800, Jiawen Wu wrote:
> > > > > > For the copper NIC with external PHY, the driver called
> > > > > > phylink_connect_phy() during probe and phylink_disconnect_phy() during
> > > > > > remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> > > > > > upon module remove.
> > > > > >
> > > > > > To fix this, move the phylink connect/disconnect PHY to ndo_open/close.
> > > > >
> > > > > Wouldn't it be simpler to just wrap the phylink_disconnect_phy() in the
> > > > > remove function with rtnl_lock()..rtnl_unlock() ?
> > > >
> > > > This is also a solution. But I think it would be nice to unify with other drivers
> > > > that call the functions in ndo_open/close.
> > >
> > > Both approaches are equally valid. Some network drivers attach the PHY
> > > at probe time (and thus can return -EPROBE_DEFER if the PHY is specified
> > > but not present). Others attach in .ndo_open which can only fail in this
> > > circumstance with no retry without userspace manually implementing that.
> > >
> > > There are other advantages and disadvantages to each approach.
> >
> > Hi,
> >
> > So is it still recommended that add rtnl_lock()...rtnl_unlock() instead of moving it?
> 
> The reaosn phylink_disconnect_phy() requires the RTNL lock is because it
> _can_ be called while the netdev is published, and the RTNL lock
> protects the networking core from the PHY being removed from the netdev,
> preventing ethtool ops into the PHY driver from running concurrently
> with the PHY's disconnection and potential later destruction.
> 
> Offering two APIs, one which requires the lock to provide that
> protection and one which doesn't would over-complicate the phylink code
> and make reviews way more difficult, as we'd now have to spot the
> wrong function being used in the wrong code path.
> 
> It's simpler for drivers that want to connect and disconnect the PHY
> at probe/remove time for them to just take the RTNL lock briefly over
> the call to phylink_disconnect_phy().
> 
> There is no "recommendation" for connecting and disconnecting the
> PHY at probe/remove time vs ndo_open/ndo_release. That's entirely up
> to the driver author. As I've already said, there are advantages and
> disadvantages of either way and that's a matter for the driver author
> to consider and select the most appropriate choice for their driver.

OK. I'll change it at v2 patch.


