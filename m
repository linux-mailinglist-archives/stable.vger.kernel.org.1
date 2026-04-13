Return-Path: <stable+bounces-235997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCCaKoTV3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:37:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 078A43EB61C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19BE43020AAB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881E73C13FD;
	Mon, 13 Apr 2026 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I/fYNAoU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B953932C3
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080125; cv=none; b=WcBuxGs4swJJCCgHjpu/nAaEeoNeMwdOFDQGeAJxRUEE8MP1VGzU8ZpN21Edpgp9wQr66Ma9/Sxh+vMGqq2uQs6hacH0QmzD+XDfnHh3aRwQITwP8iZrp1Km/riuM5EIOOq7kZ/3wpIb4ZTp989ItvA7XQxZ+lLAc805oHjKLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080125; c=relaxed/simple;
	bh=NkCG5dNKR/7tGXgar7zGy+QPPRGsKbzTG4E+VZxW6kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/ZeYDbFYcYVXOkRLfUAvLKxb92ZtE5Fxz4T6h38i/iRFOiIyJlKJHB9iafePZhxN4eTSSFl0ri6qoMps36Uso6svsqhri8smXB+WXBF0sfAsMKhuzHC2zor5EdJ/k9YlNlN1dpeSbo/UW15PoJPDmzn0SnHrXbwjH8yv+II5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I/fYNAoU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b8efed61so40763295e9.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776080122; x=1776684922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lt6lkZuAvrUzCTFC1yOHD1wDn40gr5BAHBhSXGovSE=;
        b=I/fYNAoUu+SIetY210TSK2rVyW1q+WfXLRx3GChIlpzKSnjJ2oPDEBHbiPECvoUy3t
         H9Ml6HdWbQP56sim1n6azEQ6+M2LDrRgmV3hRf60iBLav9n/cbXCuWEyEreIYyQDMkPX
         D0Nh7urgW/UaK2xGMLspocFjEeo1U7717B6cEFGAPDgw5cn3PxB4IsBcpVYRPrcuFAmQ
         SnHh+LI4/s31Lc55ImBUZC744N3F3l1C4W3OOfvJ4nBQSxNvoXexA++eaOsUZTv6e72Q
         EYoum5DieZ7URBASJv0l6zKjYgVmESBDWhbWadA1fjSR5C0Yiy0ai0Z+Vnh8QGPHpvai
         cz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776080122; x=1776684922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lt6lkZuAvrUzCTFC1yOHD1wDn40gr5BAHBhSXGovSE=;
        b=rcS+4BpQPpWsTrhVSIuKbTxp7g88gq+9M8ft6ym+HDZhjHQRU8+AbzUA7K0+Cz1oVa
         xGHWSsh8dzuUFU2Z4xFlPK9Uq2jQokClzPdfqloTZd6HeQ0enneIAjpI9tEqqI6qoLbn
         Q9IjeUZA5L4M7EdCQtu7YnGKNP9cIZZ80W76bCLg7IB/aGc8ddJ/QRnOIEkSGWSayl9V
         xJmEQVQ7Nnyhn7z26ohCe5I/W2CqVnatetC4qhP4JN92eVTj0xSu7xX2RoWztSldFi30
         Xfbna8xRV12Sac60ovIU1Ujwv9A6AbL/vne/nm8NBlh9agBQT2nIGxOXra6BGKeXvVaw
         fPTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1p+l0bzv/vdQumv9N6MPnqLd8tt9sDwgvBbmqznX4CFQK5KDZzDueGU2Z8uV8YkphFrYoQUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1IOAfimJp6Yf7SoJ9m+aA6cR0kWwvz9eUUEJWRmHr1np+vEUv
	Q3uF5jPaTU4PYPISJ/Z6CyCbPxPgAQ+mGNQQ7aSTIZFY/tyXYDmSUH8ozkVhvObEzn4=
X-Gm-Gg: AeBDieu+YxrHbAJssMHXNPscxaO+fHY9c7NAY0wM/4zfoReKge/6BH232rZmAhxYh2z
	MjzkcTjOwyC5Md80M7zBOmZxkrc5COdSUXQi41AjwKyNi5FCprazwGZQCfDbtIvI5tjBaCdR6IQ
	LQZ/3Zb2nCVGQFNntMZb9QQA8IGciWZakPSjhgHT6SqPlXyjojJSKLOXLKu6uAzdHopMZlnAYlo
	k5rRDw+kqQE1TVPOCZnQpMvJISy2tdVzl3uZbH6El70YMQstS6mVUj6WUfnNDrJJc566ELkVRjA
	UFkJRfy8AR9QpijiQK3j9iYrwxog4oFefB+DbcHC+8VUUFvrtiXCygrRJa+xCUXV1itO70kULAL
	UMtJE8mh0BqEtCmhWPQCQX5ASHZGDDToF7FB+TsD0Ev6xGTzGyw+L2RMnMTaE3MRlB1yj1bptIx
	nRz0pA3q1t4sN8ueTDemuVLkKX7y2sR0Y=
X-Received: by 2002:a7b:cd05:0:b0:488:a9c3:44a3 with SMTP id 5b1f17b1804b1-488cd4f463dmr164345755e9.2.1776080122044;
        Mon, 13 Apr 2026 04:35:22 -0700 (PDT)
Received: from precision ([2804:7f0:6401:5290:433e:afae:f475:c9f7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa586bsm18631266eec.11.2026.04.13.04.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:35:21 -0700 (PDT)
Date: Mon, 13 Apr 2026 08:35:15 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Shyam Prasad N <nspmangalore@gmail.com>, 
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>, Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] failure to reconnect on SMB server restart with
 custom TCP port (not 445): Host is down (at least since 6.6.95)
Message-ID: <xsj62z4aad54cseq4ug2cpj3x3tqjucjxkgv2c45lihhc54l5r@wjmkrz3q4r5m>
References: <20260310235642.6d9798f4@plasteblaster>
 <c66p7dr6vlujvnwczbnrmqx7monkdgdnm4rwewm76aibn7jza3@d3uik74dei72>
 <CANT5p=q2Lv4pSvEm5EWcM73b7NZsbt1kYEFJtjaAZRS6Gz_OjQ@mail.gmail.com>
 <42utcrhajix2x3feckj7ap373osq65sgfz6ximnaj4rasszret@ymhf44ddz2wh>
 <e21c9e47-36e2-4f15-a7a5-af239a0abb89@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e21c9e47-36e2-4f15-a7a5-af239a0abb89@leemhuis.info>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,uni-hamburg.de,samba.org,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-235997-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 078A43EB61C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 01:16:03PM +0200, Thorsten Leemhuis wrote:
> On 3/12/26 16:03, Henrique Carvalho wrote:
> >
> > Sure, I read the comment in the code and the MS-SMB2 protocol. The
> > protocol states that "client MUST ignore [Port] on receipt". Since we
> > are not using p->Port, I don'se see how this is a protocol violation.
> > 
> > We're using the port that was selected on mount and copied over to
> > server->dstaddr, so that when server->dstaddr is overwridden,
> > server->dstaddr keeps the user selected port.
> > 
> > Now, even if we only fix that for primary channels, the secondary
> > channels will still get the wrong port when they are overwridden, no? So
> > I don't see how that fixes the issue.
> > 
> > Apologies if I'm missing something.
> 
> Lo! What happened to this? I saw that Henrique posted "smb: client:
> preserve destination port when parsing server interfaces" a month ago at
> https://lore.kernel.org/all/20260311160856.635916-1-henrique.carvalho@suse.com/
> which looks like a fix[1] for this regression, but unless I'm missing

That patch was updated. PATCH v3 was the one that made to the tree.

See commit d4c7210d2f3ea481a6481f03040a64d9077a6172 ("smb: client: fix
iface port assignment in parse_server_interfaces").

Best,

-- 
Henrique
SUSE Labs

