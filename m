Return-Path: <stable+bounces-116605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 244ACA38A08
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 17:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3730165807
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 16:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8452253EE;
	Mon, 17 Feb 2025 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COEeIN/d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FEE219A73;
	Mon, 17 Feb 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810857; cv=none; b=OR/eOiGUNqf4SHNqtxCkuaLi0dC1W8s71wdP17oCFyU3M7Uz+79mtX6E4jiM+lk1r9vRzrHV6Wnu2FWa959FPy2RuUAEuCQMna6rumGdBzD7u8ysPAyGXVug7iQNoNv3/VAg5NMru4LelF3TfZen8b2TRKCIMN+C4HPMxQ5vwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810857; c=relaxed/simple;
	bh=sw8pTD5L7f/xyTmDClNuUdGkQf3mf7K3EDXECSx0tW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpyrj9PQkxZgKduwu0E52pR55jrZDdvYm4JBez3UgB81se9o/1UGzAFdX0gno4qWX94KNCI11ipq/DvLFk5Dijt+0xbS1uIfzBy+xP9IPfBn4+NdMl4rISl0MB+2OWvaOffPn0Qy9hWvbpojup929LhDhLqfzlmV5+Wi0ZebI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COEeIN/d; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-221050f3f00so38383055ad.2;
        Mon, 17 Feb 2025 08:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739810854; x=1740415654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5NFIOo8aeK30zNembu50MeEzUimT6pz5br8YkV9ZoA=;
        b=COEeIN/djNYdd9t8FiPoDZBjOa9b15+MupuSq7Wp8JZglanpvUWZ7dYJtAwqnNSbR9
         6jJMaLHjyYDLC/DGTcmrTvjKLQ2DR6euIw4ChwUSqj3cOsXsJjdTUk8y2bSU4yJtxCcT
         B4J/aGhV4EpqKOwLZUu7qKNF5cux3uvrExxwMWc7ngEjBZqK+dfG+MYk23pPhkNjTqoZ
         pCqFFB5dZqEly/NFZuhf9X7OdlZf8cKkblF7tC49kTy3YpK/6fYDJ4U/80KXZF0JlizR
         Ttsvz4EulatL2OFh7mRE1xjbgahx+g/m4gC7pXLoUftGqPWgr5jORXhxx8ZAq2U70QJh
         kVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810854; x=1740415654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5NFIOo8aeK30zNembu50MeEzUimT6pz5br8YkV9ZoA=;
        b=La5z0B5lKnk1BV6VHlYm2DnhQ4Hgtp4bJmHZ6CCFel4OFEsLMi8kNlPGPoPQ2GNpXN
         Krg1DIBUGEzLalyclUW7/VsoBvsgPTpTHtNyYdhYKGclKTrB04mG1VQc357i7KBHQgfl
         Xr9JxoHy5uLW51tDFYDnUXUjird4GpCEcNHPWwbpdLBSnxrcttw12cDkJ1Es7vCc+TW+
         CffrUJ09wofMhrsBu8DpXD0U2Vrd/NwYkQk5wMAcAsClEj1/4l8GY+ub55uVWTO1eFjs
         fYOhOUfqqjGcnWl8oCX+rSAAS6n3rFz0GHKSQ+V7JQGPixSuXfDGHtIWf00M7cNL5R8n
         dv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwZQuFX6CXyqLuKVkBS3jouBEo2CgqeNplcpKPK+HKUIyYjBGshgM/ahE7L27weVumKlS+xAI=@vger.kernel.org, AJvYcCXXkKfiPmjWMpWn2UVFdrIpPKOF3p9KM+fDYrKoSKIucEfXPiknd0+3cAPKCuo5EO5QUAljWd5P@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq4qVEWBVmB0kPfdgBAe0vIhLO5YcTgN/t43ATBLJ/Zh/sX783
	YB/5QCttEsdgx5c1HntD1pFGqQExACklJy8KgNPiKHtaCVf//hcwbCudOQ==
X-Gm-Gg: ASbGncvXUd1lkUbbUi78VOFxJFULUGYAu8lUV++ZTfesNT4iFJG3Q9LoKqarSas8S4i
	wDJ9Qqsh6MzwS8mUSnM36QZ29J2dRlr29E7D91TZEGwOnSY7R8d4VgdKNFN2J9eaGAcATz9QTs6
	T10/SmZklQmNsIWuG0JzjuuvR8nBDHnBDgcWmX879hSgVxQTgIrZrC/+MuQfdKorbPmZdCYPZt5
	y33s1gNOkdQBSW46CYsvIYmGtxSOECEPwG9/T7+v1nJak10N2tF+1/7tsQ5BNuE1vAd+Gd0Z5Yo
	2eHGJgk+VG5GElsAWDCkHQ==
X-Google-Smtp-Source: AGHT+IFIaPv7NyLLy/UOLz0rxwj+Ad1zK/Zvxkn4+3f9o2V+R6fuvptqhKuq5mccuBSIPdyjYCU0jA==
X-Received: by 2002:a05:6a20:93a1:b0:1ee:8bd2:5717 with SMTP id adf61e73a8af0-1ee8cc18814mr17494408637.42.1739810854231;
        Mon, 17 Feb 2025 08:47:34 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:3ed7:9c4c:c545:4371])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732521b82b3sm6602344b3a.92.2025.02.17.08.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:47:33 -0800 (PST)
Date: Mon, 17 Feb 2025 08:47:32 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Qiang Zhang <dtzq01@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [RESEND]tc-flower not worked when configured dst_port and
 src_port range in one rule.
Message-ID: <Z7NoJHQ7hLiTXuA1@pop-os.localdomain>
References: <CAPx+-5uvFxkhkz4=j_Xuwkezjn9U6kzKTD5jz4tZ9msSJ0fOJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPx+-5uvFxkhkz4=j_Xuwkezjn9U6kzKTD5jz4tZ9msSJ0fOJA@mail.gmail.com>

On Fri, Feb 14, 2025 at 05:00:30PM +0800, Qiang Zhang wrote:
> Hi, all.
> 
> recently met an issue: tc-flower not worked when configured dst_port
> and src_port range in one rule.
> 
> detailed like this:
> $ tc qdisc add dev ens38 ingress
> $ tc filter add dev ens38 ingress protocol ip flower ip_proto udp \
>   dst_port 5000 src_port 2000-3000 action drop
> 
> I try to find the root cause in kernel source code:
> 1. FLOW_DISSECTOR_KEY_PORTS and FLOW_DISSECTOR_KEY_PORTS_RANGE flag of
> mask->dissector were set
> in fl_classify from flow_dissector.c.
> 2. then skb_flow_dissect -> __skb_flow_dissect -> __skb_flow_dissect_ports.
> 3. FLOW_DISSECTOR_KEY_PORTS handled and FLOW_DISSECTOR_KEY_PORTS_RANGE
> not handled
> in __skb_flow_dissect_ports, so tp_range.tp.src was 0 here expected
> the actual skb source port.
> 
> By the way, __skb_flow_bpf_to_target function may has the same issue.
> 
> Please help confirm and fix it, thank you.
> 

Thanks for your analysis and report!

I think you are right, please try the following patch. I tested it by
myself and I am working on a selftest to cover this case.

---

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 5db41bf2ed93..c33af3ef0b79 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -853,23 +853,30 @@ __skb_flow_dissect_ports(const struct sk_buff *skb,
 			 void *target_container, const void *data,
 			 int nhoff, u8 ip_proto, int hlen)
 {
-	enum flow_dissector_key_id dissector_ports = FLOW_DISSECTOR_KEY_MAX;
-	struct flow_dissector_key_ports *key_ports;
+	struct flow_dissector_key_ports_range *key_ports_range = NULL;
+	struct flow_dissector_key_ports *key_ports = NULL;
+	__be32 ports;
 
 	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
-		dissector_ports = FLOW_DISSECTOR_KEY_PORTS;
-	else if (dissector_uses_key(flow_dissector,
-				    FLOW_DISSECTOR_KEY_PORTS_RANGE))
-		dissector_ports = FLOW_DISSECTOR_KEY_PORTS_RANGE;
+		key_ports = skb_flow_dissector_target(flow_dissector,
+						      FLOW_DISSECTOR_KEY_PORTS,
+						      target_container);
 
-	if (dissector_ports == FLOW_DISSECTOR_KEY_MAX)
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS_RANGE))
+		key_ports_range = skb_flow_dissector_target(flow_dissector,
+							    FLOW_DISSECTOR_KEY_PORTS_RANGE,
+							    target_container);
+
+	if (!key_ports && !key_ports_range)
 		return;
 
-	key_ports = skb_flow_dissector_target(flow_dissector,
-					      dissector_ports,
-					      target_container);
-	key_ports->ports = __skb_flow_get_ports(skb, nhoff, ip_proto,
-						data, hlen);
+	ports = __skb_flow_get_ports(skb, nhoff, ip_proto, data, hlen);
+
+	if (key_ports)
+		key_ports->ports = ports;
+
+	if (key_ports_range)
+		key_ports_range->tp.ports = ports;
 }
 
 static void

