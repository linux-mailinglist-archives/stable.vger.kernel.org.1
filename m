Return-Path: <stable+bounces-254031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNZZMP8FE2rU6AYAu9opvQ
	(envelope-from <stable+bounces-254031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 16:06:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 275675C2A7F
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 16:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9288C3009506
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194F23939AE;
	Sun, 24 May 2026 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvZETZ3/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50233A03F
	for <stable@vger.kernel.org>; Sun, 24 May 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779631599; cv=none; b=FLDY51H/Hn4THTXOlM8SLXdYq1DDx9eLK4ZYoLhsmoZ61+eQUQZ/UfKKFNTAvbWxyVBoZs5QGWZ9d+YXKyue8TPem54R/T2kEtb0+JB9WFlawOwmCt36yZNUokMcIcteQBsVaIe+IME+W7ibq0w1BAbFT5eXQOP7hsniR0sXw54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779631599; c=relaxed/simple;
	bh=Qz2+zOV25iTx3zbmTy6kuZTWbglGpfcZeFRXbQSmvZw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sI+pEDo8gUp46u5yO/cE0g+M0L5/4YLnKzc/I3dWjLOO9tZqAwXkd5nc9tKOfKM9hS1CFxaGXWmYqvJMfkana1/knDh53TXrL9PMQRJFI2MgynoWN7b463fSStym1PzaEC00ESlq+bWVpZtb68hanOGLNgVSddrXHFJwpDAFjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvZETZ3/; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bdc947aa88so71254667b3.3
        for <stable@vger.kernel.org>; Sun, 24 May 2026 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779631598; x=1780236398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CJjJKgtWoyZSysUUsYp4qOxs7/XAlSGmIv7oaAgT08=;
        b=LvZETZ3/p3MiybOdsZoT9LC4Q5BQyZ/wjr3jbOX0BGh4GwBHBGZfsEYeTu2mKVtWzO
         asHOcA7L43xWeDlw543bcIXzwRblNTvwErx050fQh+kbtjyBPvpNcWvzDzp8SSFzMg1Y
         w7B2ExS+6ugPGbkEjKPjG0rbRGOfYCS568dq1gmIX033cxixBI6S2V5s4UgORVSd2vnq
         3bfs6LZCJ7sWH7bK0lptkmmSh6evY9anQgx559x3UoAqrnLs78Z4n2bWfD6NjXTUp206
         W2dhEO+LJJwEI7exoXP/OuTkh/SPDh1NeaZc9nDLDcGN2uA2RmuVfb/aBP22gm4lr15N
         3tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779631598; x=1780236398;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CJjJKgtWoyZSysUUsYp4qOxs7/XAlSGmIv7oaAgT08=;
        b=CLjK/ayATfXid41CbxlGpsyY+rQfX51M/4/SMn1E+MjxbaKhBnOm4rwhs2Anf28LB2
         ISCG8fTwml7hB+ouNnh0ESrYpVzX8cACbuXJeayHgJh0FqK0PZl9h5ZkUYsjRB1olZ/+
         QsMm38SF3CaEuf9gaGvHkHn1CoINqoc9/OOOgwdsvB0wiYOdHVOGNP8HmbNYIo3W9AA9
         NOiRYUloXVH1QVHx97MrS8NQW0N6f1qmydSQoFSFQCOFTgL7VPIRwLiHtQG/bJOL7V8T
         6yy3dOaUNIg7WnAia8uc+6os+V5dBroaejmgiLTqfrhU+RewxuaSrErUnNYwTJlEwH36
         plFA==
X-Forwarded-Encrypted: i=1; AFNElJ9N2I1bhs1Tp32lSAliGfYNv4vEO9RRYLIb1zjpw5DDu/9gDEEk8b0givQIOo4m38ut0uBcl3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhpQHAfqdJMQ1ayJOkLPmhKE1VROTAukX2U0suI0k7ZfgHvH7I
	vNkWv0p0tp+Kz/+cMPN60AjY8ixKYNlEYkCkCfFMH8evLExMjf2na7oFOkLyzQ==
X-Gm-Gg: Acq92OF3SKIaAUhD5n8QQaUyYAcaD+i+iwLipjdX1wHm8EcK8IXsdvFR+f9IqK6daEK
	SBHaD1oCB1no6TOCpvkRXlbByyUA245tfn+qgrm96inD8eozDSjlKX5yHbPajkZXWFKyXRQ2+bs
	EvFjIdUIs7EWZ7AhHOOH6W6KYMqVhzF1E/TH8AlkZ7FFA9KPyYmHjsV1nho3jbHijVyb75KtUy/
	Vt9EutaFfAPFPRMlLxC/Z37OeL+rRCzH8lG96SX84cGXVBuluF0xm4GZrNDBpjTEExuYPAB2pGW
	XKO1B3nsR80ZhJpfxEHYT5rtCM41FaZVjcTRPwShYKXrLR3ez4NJgS0wbTURcOg11QILIvyWSxp
	B700Za8u4cwJxjcqNg+eEcy4PnGhp5ox6pdLGie6MkJn2P6iXt9FWTVnU5+dfg3MZe5jpt98dhN
	QWXMLtlQpcyHa4REwgjODGqSTDjsE6LWC52Lld4W+E0IXj0f9tP9OiG/DlwchZXpoJMjkMHLmZB
	5Iax4M=
X-Received: by 2002:a05:690c:4906:b0:7c5:4c4e:a8a5 with SMTP id 00721157ae682-7d336ab0731mr125169907b3.46.1779631597750;
        Sun, 24 May 2026 07:06:37 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38bf2f84esm32902807b3.31.2026.05.24.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 07:06:37 -0700 (PDT)
Date: Sun, 24 May 2026 10:06:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 lazyming <minhnguyen.080505@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 w@1wt.eu, 
 security@kernel.org, 
 linux-kernel@vger.kernel.org, 
 lazyming <minhnguyen.080505@gmail.com>, 
 stable@vger.kernel.org, 
 asml.silence@gmail.com, 
 achender@kernel.org
Message-ID: <willemdebruijn.kernel.27d7990b24613@gmail.com>
In-Reply-To: <willemdebruijn.kernel.10f46164d2a79@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
 <willemdebruijn.kernel.10f46164d2a79@gmail.com>
Subject: Re: [PATCH net] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254031-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,1wt.eu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.495];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 275675C2A7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> lazyming wrote:
> > pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> > the old skb_shared_info header into a new buffer via memcpy(), which
> > includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
> 
> These functions are not supposed to maintain zerocopy frags.
> 
> Both call skb_orphan_frags.
> 
> I think what may need to happen is to invert the order of that call
> and the memcpy. Current code:
> 
>         memcpy((struct skb_shared_info *)(data + size),
>                skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
>         if (skb_orphan_frags(skb, gfp_mask)) {
>                 skb_kfree_head(data);
>                 return -ENOMEM;
>         }

Never mind. This actually corresponds to the first Sashiko report you
mentioned: if zerocopy skbs are converted, then the memcpy prior to
that call will have stale state.

For skbs where skb_orphan_frags does not do a deep copy, we do need to
take this extra reference.

Reviewed-by: Willem de Bruijn <willemb@google.com>

