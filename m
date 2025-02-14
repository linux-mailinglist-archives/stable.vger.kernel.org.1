Return-Path: <stable+bounces-116388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D2A35991
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 10:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02321891462
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED622ACC6;
	Fri, 14 Feb 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RExNhrZs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54675155756;
	Fri, 14 Feb 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523645; cv=none; b=EIsEGkoUI5qRq4JwGqeoomWvC9dq3rfq0SWn2ihgU4Z+nGMaYGBUVbJt9JTzSiHtADrd/fkRAUs7l66b2kzV2/VG4688GBdgoZJ4OCAF4kWZBSxF9hj9mFWOIY/kMleH+FW/XaHyCTHMq0zioGNVLNbLdoTQYP3h+zPl35jzY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523645; c=relaxed/simple;
	bh=7lX+xYMFJh9I+bPXe+Txvhf9q+36wzQ9yi/jo6PJCcc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Luwy6FSIuKS8vVFmhtwivj/ESJftYptkW9nFNI+epsI8V++eHidXVTMvGq+JxzutVsI5SPgDD9mP5XdTdOPImAWj21v7rIbFHn3oWAidtWs7a8EdxLhcQJcgm3+30oYhjccpxmaPEpdtX7AleGivpbUwX7I7ZRP6fPgJ/h1QxkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RExNhrZs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-438a39e659cso12654365e9.2;
        Fri, 14 Feb 2025 01:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739523642; x=1740128442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BCeQRqKC2mbRi4qoCT2t+rHnwR2WSeqQ1KRGbRtrTlk=;
        b=RExNhrZsQIGdBfIgMpokqT4WWHxJjlIxnvr/B1J4+qUR1wz0UanV3n4FmS4TRzl10S
         yHI7azLUbqIVrsLoAakFXfV6AnbJxmt9gKg+L6p4c6WSTMttyaZ6zeDiL7DyViqd6ktD
         eAMO+Wgmkl+clzp/EHnmsMBTDVWRGj/R8wKINybmQuTMtZJ5BH/N8s+G7mPWaGMjImtE
         duHIfRB2QRYDyK3unAsNzzbfB8WwIwDfu2ybw/qGG36lojzPK37423NRgd5cc1WU/zLf
         aMJ4vcrINs9Nzj8UWGtmW9COryyExxH2mdJe6Tq++FMhJPwfPQCZHTCmc4Qw4ROBMzoN
         44nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739523642; x=1740128442;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCeQRqKC2mbRi4qoCT2t+rHnwR2WSeqQ1KRGbRtrTlk=;
        b=ee1lOirNCzMI08dxBHC3Odwx4FwLBpSQYh3hHKPDy6oEwpO7/3MHR37Uw0YNEltDrG
         vOt0V48vizgfxPp0DW+fNBYeNtkFyr8PUVA1J9gxzarrwlnRONOGwopNaeGdyvvR+ErY
         7hvYVrmquQb6hbfKk9zbXnkCZZjRI0vd0iA/Yl0e0D4SK+Wew/wpUE37mSpSkS6foSP7
         xsOwL5ansvoh20iWW42HR+F0vJZ+bU9Nx5Jq4ElNPnSuN7aCZMnf5C6BOWHVwZg/lG42
         3yVtbrQVYOL/5shWA2lEfD6O71FL4TEG7dSl8oaX27JgYWpFFstYLl54QzI8UkKGkeHR
         6rdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdloWJ2XYbbvY0sF+ARYqhPo1xWpBCCobWZaAUahVorSZ/puI69sH0ZXnsyZ0Q3v6Q7l9IV10=@vger.kernel.org, AJvYcCXpxUAmAXnJun3fYXYd3ABQSJRf3qMJrrW+Qmo7aVv7BQmYNWsra0pk6mf0dWn5UpZuo3e9jYSu@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyWjrXUfew29x48J7jtF1HsMwv31oTvgc8a8wfZuNU4Sn5Zq6
	Lo5Fv4rW8hyy0rhTVsV7iBLd9fXor/Rj79a5GgZXVrUJcsiKjT3FsM1+Qks6wwqCIHvtNYZnd7i
	sCpzSGwnf3McqoedDm75Phj08Ma9DJTyX
X-Gm-Gg: ASbGncvI8YKtqE0W+qzP2XihQ8sdiJo/i+4ZYbOxP4kjCSNxBHipWvaXzdx4+Q/C03z
	CzBpfYt1hG6o/r3tXOtw/e2YTkAoBLSzaDUXnCVlvkV8CjydggZo4O6v/K21qK6CcGV1NO7+d6q
	k=
X-Google-Smtp-Source: AGHT+IF15SfeQj3HA1ZMD+2sa81H/Bp7K68HgV09burIDohLpGXFpzE9CUzH85s9o55mFKj7h/Av1qPuDFotyK/ZIoA=
X-Received: by 2002:a05:600c:4e4f:b0:439:6332:275d with SMTP id
 5b1f17b1804b1-43963322a53mr64091465e9.2.1739523642375; Fri, 14 Feb 2025
 01:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Qiang Zhang <dtzq01@gmail.com>
Date: Fri, 14 Feb 2025 17:00:30 +0800
X-Gm-Features: AWEUYZnMyRVuMUo18B9Q4Cpr5cORWRavjMOpn-JsG2wYZUOafE0PZqTGJKToTB0
Message-ID: <CAPx+-5uvFxkhkz4=j_Xuwkezjn9U6kzKTD5jz4tZ9msSJ0fOJA@mail.gmail.com>
Subject: [RESEND]tc-flower not worked when configured dst_port and src_port
 range in one rule.
To: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, stable@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi, all.

recently met an issue: tc-flower not worked when configured dst_port
and src_port range in one rule.

detailed like this:
$ tc qdisc add dev ens38 ingress
$ tc filter add dev ens38 ingress protocol ip flower ip_proto udp \
  dst_port 5000 src_port 2000-3000 action drop

I try to find the root cause in kernel source code:
1. FLOW_DISSECTOR_KEY_PORTS and FLOW_DISSECTOR_KEY_PORTS_RANGE flag of
mask->dissector were set
in fl_classify from flow_dissector.c.
2. then skb_flow_dissect -> __skb_flow_dissect -> __skb_flow_dissect_ports.
3. FLOW_DISSECTOR_KEY_PORTS handled and FLOW_DISSECTOR_KEY_PORTS_RANGE
not handled
in __skb_flow_dissect_ports, so tp_range.tp.src was 0 here expected
the actual skb source port.

By the way, __skb_flow_bpf_to_target function may has the same issue.

Please help confirm and fix it, thank you.

source code of __skb_flow_dissect_ports in flow_dissector.c as below:

static void
__skb_flow_dissect_ports(const struct sk_buff *skb,
struct flow_dissector *flow_dissector,
void *target_container, const void *data,
int nhoff, u8 ip_proto, int hlen)
{
enum flow_dissector_key_id dissector_ports = FLOW_DISSECTOR_KEY_MAX;
struct flow_dissector_key_ports *key_ports;

if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
dissector_ports = FLOW_DISSECTOR_KEY_PORTS;
else if (dissector_uses_key(flow_dissector,
   FLOW_DISSECTOR_KEY_PORTS_RANGE))
dissector_ports = FLOW_DISSECTOR_KEY_PORTS_RANGE;

if (dissector_ports == FLOW_DISSECTOR_KEY_MAX)
return;

key_ports = skb_flow_dissector_target(flow_dissector,
     dissector_ports,
     target_container);
key_ports->ports = __skb_flow_get_ports(skb, nhoff, ip_proto,
data, hlen);
}

Best regards.

