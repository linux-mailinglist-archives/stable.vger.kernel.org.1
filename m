Return-Path: <stable+bounces-238581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kSfcMPBV42k6FQEAu9opvQ
	(envelope-from <stable+bounces-238581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 11:59:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2126C4209E0
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 11:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A315C301B901
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 09:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663063264E7;
	Sat, 18 Apr 2026 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="eZvi8Vz+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FC2DC789
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776506347; cv=none; b=SapJmV5dtSFB/pIvBBCkXgGJN6BVhn1NPJlLR+YHFMMjOFT9QzDI4cx//yPvNVVR/oNYKkpqZdX5B9yOYhqaOXedr1ioFyGMo8Sg5cL8Ept8uUH13PiLFNGmDZNhDzeHzg5yNjw/FocdsYkB0f9Q/XNbPr/WqYQkmt48v9e+NgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776506347; c=relaxed/simple;
	bh=JyK04D/r6v/XqrdArAIAPeJaBn2HrSI219E+FOFO1z4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=BEXHqLhFrJee3UCixNTSHWIjfdwoW75xm8TParpzZxHYiQGxxBx9IkmUC3BH94a7CK/By983esfPj+vSHFdOEx+dFFR1Hz3UGMaeOMI1MzZs6nPiLj3ZCrZKKww/fl6RoyovRchJG4Z+R6aVAPa2Tm8AjXh/Lhen/eQ5omJCjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=eZvi8Vz+; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d96243c91fso477518eec.1
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1776506345; x=1777111145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQDNJJps2vqzxv8G7gh+LTYfLL+5B38WSPDJRjYejk0=;
        b=eZvi8Vz+iv4tOfuWrby7E/FAS9oXPwUmMV6IAIYhyZZPSjS7nBPpydg/JGNYVeXUl5
         XWQGqYb58lKRmZXbv/q7N6tCA634Xnx2AskNOW0VRCPITH34VvCnxPpShCD51HQa3wN3
         ThT6nY9CIKbub5vqC3F7eE5hfgGD1PkjIiQMbFid3FY74d4j3m+Z98BIQnP2DXz1R9z6
         V+xewdVIGybZcSIp8LfcfZXnmI2LjHOosxUegZuRqqFoxEkzYjM9zQUQFvwqsCMsM/il
         neavmsoQCxepJ3/P9HZf558hYXD+lxeHlOPHemXa/wNJLEUJjzFNDW4SJO/Efc7ZGxvz
         2Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776506345; x=1777111145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQDNJJps2vqzxv8G7gh+LTYfLL+5B38WSPDJRjYejk0=;
        b=iCPyPbI3KpJR42LSkYBsr5lm7pCIY5Y9W/j7poZT+DfgniTDhjknEpwMJl2QyEwxYX
         lHZaRt0TsHs2p9LRVkegliScqwrfRWx5n/J5pFzhi81rjkmfGQfAjxQpwW6uBLIaLN8G
         FQ4Nawr0mg0ZG2kZDSggWiE/0AA+naP88k0XD9G/7e1QrtTB+kuh1GLmLJULn2BX8+yj
         GwgdLA5vPDhVP0ejQOd4jGOYV5qzMqpOXepngcP+M06MtS8lX0zQw91ZPe7rT+mWYbPp
         KgPP90+4QJeGq0WXJg6WWjlc+8dBxqEAV9cCOw45Ll4uH56xDE5B1CqjpsZeB8TNc5Bi
         qyxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LLLFYHsUY90MNYw9eqyZGgsLHFb/nsc6lBzyC/XAiqsceih+jv7M0eaG66tjUZQ0bBWnVE6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTleuIG96gBYv2+g3HjQlIXyvEb+gS/G03UOtZb7EvxIf0npd0
	NqtP9NhifWidmAHc6ZpxK4HLTT3NcgUtuvBE0v+AJL3tdiB35KcHlXKDrl/dHleAIzMNIMO1KpX
	ThwU0
X-Gm-Gg: AeBDietldN9lkjfAKSKAh0Fpi9brs7sP17lkZCnpJBH23X0n5RHJGWJet82QDQIgJKq
	IXff8LsTad+B3gujka7T2Vll7Wx127SCLRztOFvuaYDt5yuhMZRaSRbyKEDbhTkwMU/NZXY1DCv
	ppC27xwyLfQO3OhnqZUj21Qtz9DtFe5jnh2twwO7hiqnZ0FaYMlmRYd2c+A3u0AqRmyoDn10gzy
	brCblC7BswI76QBQyTjT5LDxzWlof6YiI7W10fGolu9Rmw4qWe8ZC9baWD9I9tHUNkEecDXAblf
	TN02WPjVkBTT4yapWRQUPPukT7yjTqRHVzo0n+13uB/5lbmZdsYMul5R7+2phoS4p3uaD1rlv7a
	pPN5yj4XLSYOCg6ozrUl0Yy8db/eV7h6adNGD9xC7mPTgp3zjEQxIa31H4FFRCvCqLnMPEAf9cf
	Jc0jRuZqu+zQtlLbMJrJQJs7IdScc=
X-Received: by 2002:a05:7300:8ca2:b0:2bd:c285:2fe with SMTP id 5a478bee46e88-2e46c396310mr3248086eec.9.1776506344700;
        Sat, 18 Apr 2026 02:59:04 -0700 (PDT)
Received: from 062ea10430ee ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm7471005eec.8.2026.04.18.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 02:59:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-5.10.y: (build) passing 'const struct
 fwnode_handle
 *' to parameter of type 'struc...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 18 Apr 2026 09:59:03 -0000
Message-ID: <177650634337.369.12638743148475442890@062ea10430ee>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238581-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,kernelci.org:email,kernelci.org:dkim,kernelci.org:url]
X-Rspamd-Queue-Id: 2126C4209E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable/linux-5.10.y:

---
 passing 'const struct fwnode_handle *' to parameter of type 'struct fwnode_handle *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers] in drivers/base/property.o (drivers/base/property.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:d1b6c3b17ff7c2164252525fdfd0d4e68224e5ad
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  49e5d20074c20b20773c6dc0f8dce0635591093b
- tags: v5.10.253

Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/drivers/base/property.c:896:48: error: passing 'const struct fwnode_handle *' to parameter of type 'struct fwnode_handle *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
  896 |         return acpi_dma_supported(to_acpi_device_node(fwnode));
      |                                                       ^~~~~~
/tmp/kci/linux/include/linux/acpi.h:756:77: note: passing argument to parameter 'fwnode' here
  756 | static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
      |                                                                             ^
/tmp/kci/linux/drivers/base/property.c:911:48: error: passing 'const struct fwnode_handle *' to parameter of type 'struct fwnode_handle *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
  911 |                 attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
      |                                                              ^~~~~~
/tmp/kci/linux/include/linux/acpi.h:756:77: note: passing argument to parameter 'fwnode' here
  756 | static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
      |                                                                             ^
2 errors generated.

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69e3511d9b5a968309e62062


#kernelci issue maestro:d1b6c3b17ff7c2164252525fdfd0d4e68224e5ad

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

