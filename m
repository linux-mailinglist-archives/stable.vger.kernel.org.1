Return-Path: <stable+bounces-262975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fffZK2V4LGohRQQAu9opvQ
	(envelope-from <stable+bounces-262975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 23:21:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E632767C82D
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 23:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=toxicpanda.com header.s=google header.b=hti7boRv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262975-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262975-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B53593122DF9
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B47A38333D;
	Fri, 12 Jun 2026 21:21:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF438838A
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 21:21:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299299; cv=none; b=QMTsS0g8C8QpAnP30FHUOXhHGtmqfSrDr7iJnW+z73AlkQhOr1BlqNH/ux7PSsTddipspUpiZiJyz+kHFtx7occr9Mgi2wdMzIv/Oqgr80XWPoaBtqnIwlAEMT4QR1iQ+r+kbE2nyjc967abPw1W1w1ji3dgI9i5TuQNNSBYVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299299; c=relaxed/simple;
	bh=2NLBDUT/2YbYk1htpDpXiMSPd9MW9FLUFef7KJHn3ZI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XWQXjvw5YTPeSFLh9nSxbK43g2fwfREz4Ca0RyPkZKsYCb+M2UkDdnQQDStpJC/Fv4mueG6Cj9BCGWzNksFMdV1lzCpXQYrNACmSe/lN+5yFtaIB9+3GSLZ17fGDMTsohxUMascXJca7faPhupKoy522QSEBlKfwtCTYtDYs5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=hti7boRv; arc=none smtp.client-ip=209.85.222.177
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9155183b42cso184962485a.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1781299296; x=1781904096; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NLBDUT/2YbYk1htpDpXiMSPd9MW9FLUFef7KJHn3ZI=;
        b=hti7boRvfTuf8L/5tYvz25AJVZ7MorYx8fbkeloHiyd6tARjS3OaH7ATljcUwRJJsT
         U3Sjr73ajXpcKSvs9aknjK+mYa7QWMxgZznSRKeJGpB0ZPmFsGxbxuwWJYVL1+VAbQph
         9j4KHRbfsmifBEPz2s7fErUsXhSG/yFMwy+GDnLyaFT+jtQWmyqwi1kf560YnqeWmLiq
         srl+W6gdbxAG/3WyPbKJQ19BgCTGl9iqkT+Vi6s8Ft/a/nJ6IL/VcJSxs4wXuLSVR10d
         YfCqlLwHA9igMHfpTTNeeYDEJuF1qwF2LL5R+ZR4aix+1YPGexJ7aQZBlQhWiMh4Ry1f
         bXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781299296; x=1781904096;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NLBDUT/2YbYk1htpDpXiMSPd9MW9FLUFef7KJHn3ZI=;
        b=lopszq6WCIllVCTOfy4DQkZBQq3JK/EifBVBeGkK11LEbAHECMVyraRv5Q0TmRzvDG
         iapPsCqn00B+nYMohirrqiIkfL1hhMQwZNdQpAcqjLBnFBfxpHplxpZE/4zB6E+lFfIP
         9/igKENB3MrkVhpRe3rUaLKjlazSQS1VB6qDEmR3JdtaUbpRaLsFNXGk2Xt+LlUODQ7b
         +VPEJlQ5fisr3cZXj5EXuh2SLOrlOi1BfjzYkXRhheg3b/1kT8sdb6QL9CJuxbgXI76P
         3M8eYinL/1BQ8Wy6keIFH6EnH1/AgRyuFYgDasvM+QbVFXSqDX2H9iMr8xYHhPHj6Uep
         nIfQ==
X-Gm-Message-State: AOJu0Yxd/3HkNuwAZyfZ71qaKBFmpP4HKgIDDWFfVBL9Ae0hjFrDEM1S
	jRCyvhteKTfa8YG99HYSv1CXwhgEub+EUNCw80sNjYbVmv7QzFAN6kPMY0WyctC3noozFfrG/Uj
	4AyYe
X-Gm-Gg: Acq92OGzShx/W89OIrFLuVG6vAtTuL+8+uAa1DbVBu2/+E5r4qfUmoeScixqfrGUYgR
	9Uj0yH41TYbAjm5ZfIjXjSzyHPSVfsdIu7XCrdpof0dGlpiJbCkV6r3xuPw/GFUIsnTgT2+rL38
	B2zRJd/3OMIoYfSUVrLSIQfCp30FKMRtFB5ODYe8RsVHMW90Jvp+XPTSuU6kYfpY4z1xU60tdEn
	upGyvFdo2OUL20XX/OQO92wcZ97e3GlSqt3uh/dYEu+h/TjeCTuAPan3ArCD6KvxpsBDCx4RtGg
	2QsZXyHisTNuYSdpScny5dzXNL3h2iLXODY1n3FWtlHV/iruBzt0jXkEiN6R/6PLnIF5JBJFoME
	NDs2w+OGmlNZh9eaeU4udfU7yUni+DKkVxqMZCt+qj2RG+KQGNN0TMcW70MG8sBreJ1LHYxUbr3
	ogpk3WIldp0tIsQpzGbj4+JcM9tp6QcFzxmUqZ
X-Received: by 2002:a05:620a:a0cb:20b0:915:4c9b:4120 with SMTP id af79cd13be357-91619f3f226mr496968085a.37.1781299296466;
        Fri, 12 Jun 2026 14:21:36 -0700 (PDT)
Received: from localhost ([2603:6080:7702:ce00:dabb:c1ff:fe4f:43a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a073548sm328378885a.46.2026.06.12.14.21.35
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 14:21:35 -0700 (PDT)
Date: Fri, 12 Jun 2026 17:21:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: stable@vger.kernel.org
Subject: Please apply e1b849cfa6b61f1c866a908c9e8dd9b5aaab820b to 6.12.y
Message-ID: <20260612212134.GA3841315@perftesting>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[toxicpanda.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262975-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[toxicpanda.com];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[toxicpanda.com:+];
	FORGED_SENDER(0.00)[josef@toxicpanda.com,stable@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josef@toxicpanda.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E632767C82D

Hello,

AUTOSEL already grabbed the other two patches in this series, but this one is
equally important and we're currently hitting problems in production without
this patch. It applies cleanly to 6.12.y. Thanks,

Josef

