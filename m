Return-Path: <stable+bounces-211881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLKQGNgFeWlcugEAu9opvQ
	(envelope-from <stable+bounces-211881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:37:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466499337
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BC00300468F
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7AF327C0F;
	Tue, 27 Jan 2026 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HFopyFhc"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BF1246BC6
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539027; cv=none; b=GnFmksJuvdN4ig5f8wL0vViRnmoDURHJgxsBjGN+yZqpRpYy0h88E7rqOuuBs6XHrn9DO55HkaSVPh49HZbi5oI42i0amrRcbWkyziDThZf7XAqTna4AenxeCbsVb2wqCAHCm6JCLbMZsTy+v/uDip8su8rpfXiaSbqt5VBobgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539027; c=relaxed/simple;
	bh=teAZMbI2AVQL+quc4ICpSEwSioo/BAWZQCEXQEbu1eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ch1mHtgBxYj22+Igig7Fh3NF2ZqOvhytkqvOqAcrjSt+g/pYJAo/iikx8ZIN5v7+manxdhxQnOfU5mnT+Eo2SqksjQZEPOD0jNdVJsD+zcazQLQZNQAldJlhvWVUleXPex6gm2VGi7Ikb+Hjgq2lX3Und+BxB6pSM7cg4YojXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HFopyFhc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 571B220B7165; Tue, 27 Jan 2026 10:37:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 571B220B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769539026;
	bh=QgepVqiF+kZbIdKMl73+/Ujwi+aEY2NJMBQV2clfcQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFopyFhcKIcnRWw+U7zcTzoujZZRbMo/ACujN+UMfa/ezNnKGA2Qb9hPeKuBZ8oek
	 6Qp0yXIvhZ6xryRonrhNrsl7CguDBQNtniYaAG6t79g/4XE9Y9aiU3F5twukgQfihH
	 of53eew1dfayMHK8sDRpdCIfWdbJRcovFdXj50Yw=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: cascardo@igalia.com
Cc: gregkh@linuxfoundation.org,
	lizhi.xu@windriver.com,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	tytso@mit.edu
Subject: Re: [PATCH 6.6 176/737] perf arm-spe: Extend branch operations
Date: Tue, 27 Jan 2026 10:36:56 -0800
Message-ID: <20260127183706.458136-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <aWEFUlM6PsTMMXxr@quatroqueijos.cascardo.eti.br>
References: <aWEFUlM6PsTMMXxr@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-211881-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,340581ba9dceb7e06fb3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8466499337
X-Rspamd-Action: no action

Hi,

It appears that this patch broke the build, see:

In file included from util/arm-spe-decoder/arm-spe-pkt-decoder.h:10,
                 from util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:
linux/tools/include/linux/bitfield.h: In function ‘le16_encode_bits’:
linux/tools/include/linux/bitfield.h:166:38: error: implicit declaration of function ‘cpu_to_le16’ [-Wimplicit-function-declaration]
  166 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
      |                                      ^~~~~~~~~
linux/tools/include/linux/bitfield.h:149:16: note: in definition of macro ‘____MAKE_OP’
  149 |         return to((v & field_mask(field)) * field_multiplier(field));   \
      |                ^~
linux/tools/include/linux/bitfield.h:170:1: note: in expansion of macro ‘__MAKE_OP’
  170 | __MAKE_OP(16)
      | ^~~~~~~~~
linux/tools/include/linux/bitfield.h: In function ‘le16_get_bits’:
linux/tools/include/linux/bitfield.h:166:54: error: implicit declaration of function ‘le16_to_cpu’ [-Wimplicit-function-declaration]
  166 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
      |                                                      ^~
linux/tools/include/linux/bitfield.h:163:17: note: in definition of macro ‘____MAKE_OP’
  163 |         return (from(v) & field)/field_multiplier(field);               \
      |                 ^~~~
linux/tools/include/linux/bitfield.h:170:1: note: in expansion of macro ‘__MAKE_OP’
  170 | __MAKE_OP(16)
      | ^~~~~~~~~
linux/tools/include/linux/bitfield.h: In function ‘be16_encode_bits’:
linux/tools/include/linux/bitfield.h:167:38: error: implicit declaration of function ‘cpu_to_be16’ [-Wimplicit-function-declaration]
  167 |         ____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu) \
      |                                      ^~~~~~~~~
linux/tools/include/linux/bitfield.h:149:16: note: in definition of macro ‘____MAKE_OP’
  149 |         return to((v & field_mask(field)) * field_multiplier(field));   \
      |                ^~
linux/tools/include/linux/bitfield.h:170:1: note: in expansion of macro ‘__MAKE_OP’
  170 | __MAKE_OP(16)
      | ^~~~~~~~~
linux/tools/include/linux/bitfield.h: In function ‘be16_get_bits’:
linux/tools/include/linux/bitfield.h:167:54: error: implicit declaration of function ‘be16_to_cpu’ [-Wimplicit-function-declaration]
  167 |         ____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu) \
      |                                                      ^~
linux/tools/include/linux/bitfield.h:163:17: note: in definition of macro ‘____MAKE_OP’
  163 |         return (from(v) & field)/field_multiplier(field);               \
      |                 ^~~~
linux/tools/include/linux/bitfield.h:170:1: note: in expansion of macro ‘__MAKE_OP’
  170 | __MAKE_OP(16)
      | ^~~~~~~~~
linux/tools/include/linux/bitfield.h: In function ‘le32_encode_bits’:
linux/tools/include/linux/bitfield.h:166:38: error: implicit declaration of function ‘cpu_to_le32’ [-Wimplicit-function-declaration]
  166 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
      |                                      ^~~~~~~~~
linux/tools/include/linux/bitfield.h:149:16: note: in definition of macro ‘____MAKE_OP’
  149 |         return to((v & field_mask(field)) * field_multiplier(field));   \
      |                ^~
linux/tools/include/linux/bitfield.h:171:1: note: in expansion of macro ‘__MAKE_OP’
  171 | __MAKE_OP(32)
      | ^~~~~~~~~
linux/tools/include/linux/bitfield.h: In function ‘le32_get_bits’:
linux/tools/include/linux/bitfield.h:166:54: error: implicit declaration of function ‘le32_to_cpu’ [-Wimplicit-function-declaration]
  166 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
      |                                                      ^~
linux/tools/include/linux/bitfield.h:163:17: note: in definition of macro ‘____MAKE_OP’
  163 |         return (from(v) & field)/field_multiplier(field);               \
      |                 ^~~~
linux/tools/include/linux/bitfield.h:171:1: note: in expansion of macro ‘__MAKE_OP’
  171 | __MAKE_OP(32)
      | ^~~~~~~~~
linux/tools/include/linux/bitfield.h: In function ‘be32_encode_bits’:
linux/tools/include/linux/bitfield.h:167:38: error: implicit declaration of function ‘cpu_to_be32’ [-Wimplicit-function-declaration]
  167 |         ____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu) \
      |                                      ^~~~~~~~~
linux/tools/include/linux/bitfield.h:149:16: note: in definition of macro ‘____MAKE_OP’
  149 |         return to((v & field_mask(field)) * field_multiplier(field));   \
      |                ^~
linux/tools/include/linux/bitfield.h:171:1: note: in expansion of macro ‘__MAKE_OP’
  171 | __MAKE_OP(32)
      | ^~~~~~~~~
linux/tools/include/linux/bitfield.h: In function ‘be32_get_bits’:
linux/tools/include/linux/bitfield.h:167:54: error: implicit declaration of function ‘be32_to_cpu’ [-Wimplicit-function-declaration]
  167 |         ____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu) \
      |                                                      ^~
linux/tools/include/linux/bitfield.h:163:17: note: in definition of macro ‘____MAKE_OP’
  163 |         return (from(v) & field)/field_multiplier(field);               \
      |                 ^~~~
linux/tools/include/linux/bitfield.h:171:1: note: in expansion of macro ‘__MAKE_OP’
  171 | __MAKE_OP(32)
      | ^~~~~~~~~
  CC      util/thread.o
linux/tools/include/linux/bitfield.h: In function ‘le64_encode_bits’:
linux/tools/include/linux/bitfield.h:166:38: error: implicit declaration of function ‘cpu_to_le64’ [-Wimplicit-function-declaration]
  166 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
      |                                      ^~~~~~~~~
linux/tools/include/linux/bitfield.h:149:16: note: in definition of macro ‘____MAKE_OP’
  149 |         return to((v & field_mask(field)) * field_multiplier(field));   \
      |                ^~
linux/tools/include/linux/bitfield.h:172:1: note: in expansion of macro ‘__MAKE_OP’
  172 | __MAKE_OP(64)
      | ^~~~~~~~~
linux/tools/include/linux/bitfield.h: In function ‘le64_get_bits’:
linux/tools/include/linux/bitfield.h:166:54: error: implicit declaration of function ‘le64_to_cpu’ [-Wimplicit-function-declaration]
  166 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
      |                                                      ^~
linux/tools/include/linux/bitfield.h:163:17: note: in definition of macro ‘____MAKE_OP’
  163 |         return (from(v) & field)/field_multiplier(field);               \
      |                 ^~~~
linux/tools/include/linux/bitfield.h:172:1: note: in expansion of macro ‘__MAKE_OP’
  172 | __MAKE_OP(64)
      | ^~~~~~~~~
linux/tools/include/linux/bitfield.h: In function ‘be64_encode_bits’:
  CC      util/thread_map.o
linux/tools/include/linux/bitfield.h:167:38: error: implicit declaration of function ‘cpu_to_be64’ [-Wimplicit-function-declaration]
  167 |         ____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu) \
      |                                      ^~~~~~~~~
linux/tools/include/linux/bitfield.h:149:16: note: in definition of macro ‘____MAKE_OP’
  149 |         return to((v & field_mask(field)) * field_multiplier(field));   \
      |                ^~
linux/tools/include/linux/bitfield.h:172:1: note: in expansion of macro ‘__MAKE_OP’
  172 | __MAKE_OP(64)
      | ^~~~~~~~~
linux/tools/include/linux/bitfield.h: In function ‘be64_get_bits’:
linux/tools/include/linux/bitfield.h:167:54: error: implicit declaration of function ‘be64_to_cpu’ [-Wimplicit-function-declaration]
  167 |         ____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu) \
      |                                                      ^~
linux/tools/include/linux/bitfield.h:163:17: note: in definition of macro ‘____MAKE_OP’
  163 |         return (from(v) & field)/field_multiplier(field);               \
      |                 ^~~~
linux/tools/include/linux/bitfield.h:172:1: note: in expansion of macro ‘__MAKE_OP’
  172 | __MAKE_OP(64)
      | ^~~~~~~~~

BR,
Hamza

