Return-Path: <stable+bounces-241960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEeSB+GR8mlhsgEAu9opvQ
	(envelope-from <stable+bounces-241960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:18:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D46249B4DB
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FBBD301E7DB
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067139A07B;
	Wed, 29 Apr 2026 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caWg3WXG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14643822BA
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504730; cv=none; b=M7FrWI0y0ABWJ8LIEljMa31rS8bIn6ybIRuQPAKhfOTogECU8fgdb9Ycw2vT7H0ygK8eaUEDHXt6cN3aovUQrTKz0s3Jvju4d80JI2Iwg9peaxU0+q+zA4AYs5MjXilmLiRt34sVm5Jmz8aULS7UJotpwUhq5jO3S2s3pzhd45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504730; c=relaxed/simple;
	bh=Zj6EyFrG27dVsJjtN+0O1fbv1ApMVh3gWAYYHZskTM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpQjdqhZ7qPrVnbeKvgTKjafSaI0xYXWXgY5Gefftv4JGPSyF/GN40iF0atDoS9DPr6WkmI/n26oQn9oc71AIxYwVKp9bNVkHcew1Owa2RfR1G2QemhhQAI9pNgfw0r4wYu+aKlSHcI/atdGIA+OkI9Mr54o/mCyGkw37h+Wq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caWg3WXG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf7683a28so191717f8f.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777504727; x=1778109527; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuEsegkyryEZOXO6Gpz2sASCEUkFJVzUSqqEieVk9oU=;
        b=caWg3WXGKp44I12qv99rvWt3QFDrvhK/4kKfOurlP6az3hjb+gCKmYyvkucX5fIQU6
         n1N+lJi0AmbB+CPJqEVm/cgL01toJgNx5Ew9fFroeKy+jrsrbVD5PNPSJUfUbXSKfoBa
         Hq3ZHZ782d7aqnluvlOUZ96GxIQ4uxclYLEc7YxIxESHlctCZNgcavc+ODNCAYzrSOa2
         DD+jntWqvSmymvxTja2zMx38cReuXZoZ0HmmY0KKH03lWi60rNhZ10YC0nV9hAon7wU9
         y8Shzg0113ny1P5hxFAAfNYFUR1zt9Ko38voHpYeW4b1uD7kkKiZFZTFh72vzaOl2qOu
         c4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777504727; x=1778109527;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FuEsegkyryEZOXO6Gpz2sASCEUkFJVzUSqqEieVk9oU=;
        b=RoP7BwAW8G1eAgd+6ORjB9EWFGydNEnAkRsVAeBKi83ERpaje00M6Blz96PnreraQT
         1pifxntRy90gte48JYsYXm65PhFtVmmc3P6d8+FgUHyxU1c3uNDGHVwaSe7xG6RfThBD
         X97WeQL8LTQqyattI/Klmsq+GzqYSqXF0on8iC0wVI25E0NIE6UcvO8h9/7rm8IhvRoJ
         B5J2K2FZv7awcUUOTobeThCvvCk+aanlvLHWiH/vpNcXHevYUXxNKPtuO/j6Yc0Fw2IR
         ee+A8e7vRHXZM0mU6huphupWPiEi/aAk4h6uBQHlIlMWRSZK4QYNzsdM1zEPSLpNWNVw
         v7yQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FWHj8OSGUStjaA25bNk9u4TDEMpIZ9xEWbkyZ4mtAaFR6ccbfCUvUVo/ovKrCWLzZ4Ec7WUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZ76tVp/GoIk3R8+wkKQVxECLT00qcDhK4nqrZv7n2fyuDFJ6
	YRI9B/hWWtZMrnSfzx2zQjTmr9KHFjXVEa/HtEOieskBGlDz0CUjlXw=
X-Gm-Gg: AeBDietkp45u4rw3wrCA6721bbD8ZL9fK8ZinLp/5srrM985tIbQ3YRG39wfpcEMbpB
	WvjnlkTt4oy/C/LlAY/KgofKLLz5MHNutqfChxlY4FYbpcOubMj9n1Vl63DccS98cNqkLkDDm29
	VtJxHwP80NLAwnpL1V9hMkdtjXh2MhC7VASW52ttriMpegbewiwSCnBI8GHe9us/p/SLJyZnFrG
	xIBkkZlnG01frASltWqZ2PT6pjAClg88slmDcybORJHgAFgXj7DJ1egjqUhTl9KauYocsJom13i
	9N++OJyDG+4eQnxyW9uDwcNjUGbjKE4heyIAxcVzgU6UIi2bno841DfsXRYV0C0JGfyw1HkiC/8
	b14R6KigBETYVbEjww8VRdMKeX7lF2tUc0cfCqNoKeqVavFkQUhQp1OsUnwkddQTaJpEvQ0HoCe
	qJWUtM6gEh3UXRCQ==
X-Received: by 2002:a05:6000:26c2:b0:43d:71f4:7ed4 with SMTP id ffacd0b85a97d-4493d4120c0mr627963f8f.15.1777504726704;
        Wed, 29 Apr 2026 16:18:46 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c00sm8707525f8f.25.2026.04.29.16.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 16:18:46 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH v2 0/2] netfilter: fix NULL ops dereference in iptable lazy init
Date: Wed, 29 Apr 2026 23:18:45 -0000
Message-ID: <177750472539.3004201.15967003942391945312@talencesecurity.com>
In-Reply-To: <20260429175613.1459342-1-tristmd@gmail.com>
References: <20260429175613.1459342-1-tristmd@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8D46249B4DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241960-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:mid]


v1 moved the ops allocation before xt_register_table(), but as Phil
Sutter pointed out, new_table->ops is still assigned after the table
becomes visible via list_add() inside xt_register_table(). The race
window was reduced but not eliminated.

v2 takes a different approach: guard the pre_exit path against a NULL
ops pointer. If cleanup_net races against lazy table init and finds the
table before ops has been assigned, it simply skips the
nf_unregister_net_hooks() call. The register path will either complete
normally or fail and clean up via __ipt_unregister_table().

v1: https://lore.kernel.org/netdev/20260429175613.1459342-1-tristmd@gmail.com/

Tristan Madani (2):
  netfilter: ip_tables: guard ipt_unregister_table_pre_exit against NULL ops
  netfilter: ip6_tables: guard ip6t_unregister_table_pre_exit against NULL ops

 net/ipv4/netfilter/ip_tables.c  | 2 +-
 net/ipv6/netfilter/ip6_tables.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

