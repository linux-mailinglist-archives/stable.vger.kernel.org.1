Return-Path: <stable+bounces-233201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMRcFJ3gz2kS1gYAu9opvQ
	(envelope-from <stable+bounces-233201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:45:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DFD395EAA
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FBF630937CC
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11423C872D;
	Fri,  3 Apr 2026 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThexqAzw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D163B7748;
	Fri,  3 Apr 2026 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230680; cv=none; b=A9qJQPELtdJ0jzuwILAMF8koNgScuCuxuVNGPRWqD6CVctWIKZkm5OABKQtRAL2vvhHLB9wB8cxrcu10TnQrCT+MC4rE6mDks3KuaKX+DU+rEPWuSHWCr4Vx6Z/6HdNBvTDCJJW18IncMapCYy8UFQRUuk/K6AIch1YbtvomZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230680; c=relaxed/simple;
	bh=YMdC88NfcjjBQdTnGVu7BwTVATQ44Rq3GhtgP2i+B+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0hVVIo+8a3O5iviQIAgwlKZ1GLUE9tzTI1XbLtCp5mFauugBHNiHd63ll/P/rfNoSgpfHxCKtwuMV40dA/Pn+T5PeIHL3pgQg36C5U/RrO/jNug/p46V710ZQ+5F2AoS7QQojOvxKBaLPG7U9pk6zsgCUkP57UbX4FjodHJswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThexqAzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA5C4CEF7;
	Fri,  3 Apr 2026 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775230680;
	bh=YMdC88NfcjjBQdTnGVu7BwTVATQ44Rq3GhtgP2i+B+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThexqAzwKKdK4nfvw6o+40xhFNOQJOw6GykOUrMZRz0iIKLAgXAxOdN+xeQYB13jI
	 r7Tf0tSMvugl/ff+pWIe+S1vbVmIujo6CoYjvSlesBkJPBsYJcudC0Gxoj/5MMvDOt
	 OPFs2zrFtCnO/fp4RoTbztAVMo7FUsCmqFRzNYdAM8M9/62JTmG94cC2R1soParoeB
	 vKRn1E4vcr/QS/GPA/PdMsqpgvPiNEQ2cb+Jfw+iqbaEaOcMFyHHKmxvzb3fXqkbGg
	 tlOO1j+GcXgP5J0YQ8gYVCOp1DIFi9i1J7xvpWJjHEAPZzIw3xdZVADG58QHPYFvhT
	 GP1dxVJSfFL9g==
Date: Fri, 3 Apr 2026 16:37:55 +0100
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: qualcomm: qca_uart: report the consumed byte on RX
 skb allocation failure
Message-ID: <20260403153755.GK113102@horms.kernel.org>
References: <20260402071207.4036-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402071207.4036-1-pengpeng@iscas.ac.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233201-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2DFD395EAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:12:07PM +0800, Pengpeng Hou wrote:
> qca_tty_receive() consumes each input byte before checking whether a
> completed frame needs a fresh receive skb. When the current byte completes
> a frame, the driver delivers that frame and then allocates a new skb for
> the next one.
> 
> If that allocation fails, the current code returns i even though data[i]
> has already been consumed and may already have completed the delivered
> frame. Since serdev interprets the return value as the number of accepted
> bytes, this under-reports progress by one byte and can replay the final
> byte of the completed frame into a fresh parser state on the next call.
> 
> Return i + 1 in that failure path so the accepted-byte count matches the
> actual receive-state progress.
> 
> Fixes: dfc768fbe618 ("net: qualcomm: add QCA7000 UART driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


