Return-Path: <stable+bounces-253433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD0XN3puDmqN+gUAu9opvQ
	(envelope-from <stable+bounces-253433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 04:31:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 539DE59E19C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 04:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F403309DE7D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D8932C942;
	Thu, 21 May 2026 02:29:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAD32E75A;
	Thu, 21 May 2026 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330557; cv=none; b=Vnol9t2VkcAoMztmjknk7l0laX7sx0gT2wY/X2SLFHA1l1vNf+MJMcEHHsC0d/R7qDtcftX7kHjbL1hg6H0Sm7yru9ztxh7P2cGmW7adZX5VX4VxZdjZWMDzJ6I3Bl/686o4ggEmKmuWO2KRyoLDYB+0tD8K4c7s1uy+cknDn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330557; c=relaxed/simple;
	bh=LlnEPrifEILY8fybpTpAoZyGZNu8Z07qsH1R3m03WSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7mcv3e9IKfBHQfomDS44Wk7Jx25TmYgucK/Hi9zYBr55eIl1t3VcNGAAR5PJXVqWdXMwLZ99kqSHkeSqac1S9C3aqlTBuUSOpATDSlmCSmeR+J91Ub5eXGvdGpAL+ImfGGMDAHjHlnihPR4KMhk321jnXYwixaTg0A7OsJDCzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowACXtdzobQ5q2LXAEQ--.21597S2;
	Thu, 21 May 2026 10:28:56 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Daniel Gomez <da.gomez@samsung.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] params: bound array element output to the caller's page buffer
Date: Thu, 21 May 2026 10:28:54 +0800
Message-ID: <20260521022854.38938-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <5bfa28de-9d37-45c2-8c0f-e93b36119910@suse.com>
References: <20260417075042.26632-1-pengpeng@iscas.ac.cn> <20260507082103.94473-1-pengpeng@iscas.ac.cn> <5bfa28de-9d37-45c2-8c0f-e93b36119910@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXtdzobQ5q2LXAEQ--.21597S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw18tFy7Gr47CF13WryfJFb_yoW3CFXEga
	92qr1vk3WDZrs2ya1xCF90yw42gayj9rW8Gr4vqryFvw10yFZ5Wr48trnYvr47Ga1xtr9I
	gr95JFy2ywnxAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbtxhJUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-253433-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iscas.ac.cn,samsung.com,google.com,kernel.org,atomlin.com,yandex.ru,linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 539DE59E19C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Petr,

You're right, that changelog bullet was misleading.

v1 already broke out of the loop once off reached PAGE_SIZE - 1, so it
would not enter another iteration with no remaining byte in the caller's
page buffer.

The v2 change was narrower: after the element getter returns, it clamps
the number of bytes to copy and only rewrites the previous '\n' separator
when that clamped length is non-zero. That avoids turning the previous
separator into ',' when the next element contributes no visible bytes
after clamping, or if a getter returns 0.

The bullet should have said:

- avoid rewriting the previous separator when no bytes are copied from
  the next element

The code change itself still matches that behavior. I can resend with
the changelog corrected if preferred.

Thanks,
Pengpeng


