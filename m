Return-Path: <stable+bounces-230876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCSwBkbyyGlEsgUAu9opvQ
	(envelope-from <stable+bounces-230876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 11:35:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B1835166F
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2D53014101
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B32F5474;
	Sun, 29 Mar 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uLyCHeu0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6A3016EE
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774776889; cv=none; b=O5t9DhdxO3CVEqJLMEazKOVYmXqfAhj8n85D93loAU/Qzp2iBnl9xV8cTfPipo20losclLlCU6FlRmxHbpqQRMbutIjyStdf3ESq/VJtGWkWiwCtkaLPq+LAj4S8z7HfwiYZrGNT3VJIW3ANcJ9ic80raVXhNyNA/T/YFeG7fjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774776889; c=relaxed/simple;
	bh=1S4IUr+dOo3+BS3TFfD4ge8BWm0X76VbuVunqrfBYDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1X0vFlTe+fDzyVEAF6C9ZGJtbjwiL6aPQ/lyt7rurgy09amdnnZ56RVAX1J/K6mrLlRs+qvXwmYW3iZPhLDvrO+rFbvSQbqFuPRBpsJ/17jjuRFKK5lLKJRq7ugydJ60/ujhL16nlp9iFzycsZ5n9myPPYvKL11K1y7XNDZdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uLyCHeu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D9DC116C6;
	Sun, 29 Mar 2026 09:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774776888;
	bh=1S4IUr+dOo3+BS3TFfD4ge8BWm0X76VbuVunqrfBYDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLyCHeu0XNA9h4Hv0lZq/wtWWEGDlxfGaj1sc9uXpzR0zjWMIVME5usuCdYQXr9Dt
	 LjgpqYCJSzoynZUpYSek7+L43GEpdEnr/JQgf3xOaEVIFkrHtMmWwmaLSSmOgh0bsj
	 qniOSCxmL5iJrfQXsplRtpVHnGVei1f6qTm8+jQw=
Date: Sun, 29 Mar 2026 11:34:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Changjian Liu <driz2t@qq.com>
Cc: stable@vger.kernel.org,
	syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+77026564530dbc29b854@syzkaller.appspotmail.com,
	syzbot+5054473a31f78f735416@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Junxiao Bi <junxiao.bi@oracle.com>, Jun Piao <piaojun@huawei.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Joel Becker <jlbec@evilplan.org>, Mark Fasheh <mark@fasheh.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] ocfs2: add extra consistency checks for chain
 allocator dinodes
Message-ID: <2026032906-unashamed-variable-1ea3@gregkh>
References: <tencent_3C8D7C8EE9DF1B910A7643AA5ACE97481808@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3C8D7C8EE9DF1B910A7643AA5ACE97481808@qq.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230876-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,yandex.ru,linux.alibaba.com,oracle.com,huawei.com,gmail.com,suse.com,evilplan.org,fasheh.com,linux-foundation.org];
	TAGGED_RCPT(0.00)[stable,1dd53396e7124586dca9,77026564530dbc29b854,5054473a31f78f735416];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74B1835166F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 05:13:52PM +0800, Changjian Liu wrote:
> [ Upstream commit e1c70505ee8158c1108340d9cd67182ade93af4a ]
> 
> ocfs2: add extra consistency checks for chain allocator dinodes

For some reason you did not address my previous review comments, so I'm
going to have to delete this and ignore future submissions until you
work with someone who can help you with the development process and will
submit changes that they have approved first.

sorry,

greg k-h

