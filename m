Return-Path: <stable+bounces-259414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gXgiNF3qHGp/UAkAu9opvQ
	(envelope-from <stable+bounces-259414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 04:11:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444E618C0C
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 04:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA4833003980
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FEC1E5201;
	Mon,  1 Jun 2026 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuHnxVUI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E4C1D5160;
	Mon,  1 Jun 2026 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279900; cv=none; b=SUUgTaQrLZ9LO3ouUAjD081zUywhhvQjU8DtqVCmFmKiiQW1Ddj0GsNBOA7EahEKb8kjAVbheP9wjn/gkvTl02VzY35fqOsBzWnZpNFaJ7OlkZcyksqdxIsYihOoRGO+9Od0emWclTt8NDq9fk7Wjoqa8VHJ7WsR82BLl21PVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279900; c=relaxed/simple;
	bh=weD7M+njzOS+uY17eQHmNRyd464yyzYHrEKE1I3Py28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjRmurO/BGCyoLdOzN4R4NSaCj6QsQQcJodeUadLIt5zedHsxbyVVx7PA2vFhwpY+7UWscOEUWULkMIRkw79dJekod/8lK0G8CLlHQiLhK3M8486hRFFfhNz+ZJq+sZ/0rUQFszgIBHc5Yy3/qgDCPO1kiJ6YA3ArlxUTsMsVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuHnxVUI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038E31F00898;
	Mon,  1 Jun 2026 02:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780279899;
	bh=weD7M+njzOS+uY17eQHmNRyd464yyzYHrEKE1I3Py28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YuHnxVUII6Id9E8AEUSCi56EYvBueeWm5IiYuaTxQl9+yIWRENNyTmLTm586Nmkm9
	 oeC+PzfqO4JBu2x6lJTPvWwOhaGH0YgomzLyFcPJcdvv/G8NRkchyJoMTCTJR1rSeK
	 7jbftZ+h75nB8mA9r0X2qzWU78ExZBuYRJQAqabqNtYrUkyPf0V+XiMLPciH3juf7G
	 TkXJRqmSbRDRR1juJ43iym6Xu1Utgg4c3ILMNWRDErWAimVsYSRq7xw4B0W98rEF8d
	 v/kBbb1fkS//Lh/H2hgh4aXLQWkDDDqeJZDffmCmZyQmFUcYHreJ0F1/25q9gzCEAs
	 X14JOGf2aq5ig==
From: Sasha Levin <sashal@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@vger.kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 5.10 101/589] rxrpc: Fix key quota calculation for multitoken keys
Date: Sun, 31 May 2026 22:11:23 -0400
Message-ID: <20260601015021.rc-rxrpc-key-quota@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <866e188244055e8b90d632cb82e2badb40946706.camel@decadent.org.uk>
References: <20260530160224.570625122@linuxfoundation.org> <20260530160227.359961685@linuxfoundation.org> <866e188244055e8b90d632cb82e2badb40946706.camel@decadent.org.uk>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259414-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5444E618C0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-05-31 at 15:20 +0200, Ben Hutchings wrote:
> Indeed 5.10 does not have that key type, but it does have
> rxrpc_preparse_xdr_rxk5() which I think also needs to be updated.

I've dropped this from the 5.10 queue and will re-queue once a complete
backport that also converts the rxk5 path is prepared. Thanks for the
review.

--
Thanks,
Sasha

