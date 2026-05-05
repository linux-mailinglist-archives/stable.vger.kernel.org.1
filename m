Return-Path: <stable+bounces-243964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOxtM9Z5+Wnz8wIAu9opvQ
	(envelope-from <stable+bounces-243964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:02:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D60F74C6A3D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 174DC301C8EE
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E893CB2E5;
	Tue,  5 May 2026 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrLcJtno"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B273C5DDB
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957211; cv=none; b=fs2IPm7mR0DQmS9MeKLpxISz6F9vMIpt5b3l70K01N5SZvZkx0kA/fhuM0WpvMu+jLw7Ea/52SqGARCxdmkEMJFghdCr3jjS/BvSA5boIzGch6If2AbQ8qcb8EG1RzS7QnXOhh7hrdIkH1ovhHyeBeil97j2zXzPBtaa4KinqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957211; c=relaxed/simple;
	bh=OE7RwNJe3nm3qgZgFykw16tgadYTz+cmpc/WT0kxgP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OurjcaJtdhFms00nSpF+qj6vdnUvT5ySSHlH/JsVFvq97lLqTP+Cq41h1EBEwzvFaR6RH6PCe6Mx07BfsYh1iX6lQVUJ02JUp/d7vbqNf9KAb5XXJeT4Eb94/yGyGQgUnpYaqaJmZqLiFFQD2kY4s81k7kPTDvSoOf7s1FIJX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrLcJtno; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso10802808c88.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957210; x=1778562010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y28fQgT8s+6wgnNieeWIuVixLHD6fzupoBYBwsX0f0=;
        b=GrLcJtnoHGbrKsmYSA3vgXa2wnk9gPTvOrhmO+DWf64eEp6In+BMwPXZGI3AtGsrI0
         Yupw71cDod6/oRUkmp9+jaYLrdpTyi9AkM1tQlkWDcDQrc7XMZt3p3VVPi6blTIuR1Q0
         9ed+5Mfe3gXxtYXuEtU/QENIXftMQp8SGIxLY2rh0afKVcN7TX7Rwu7jflABLXafoKjh
         S6AFTLY/x9noRQXSruaeUqw/a7uKzRloRJVCP6TGPR6N65/B2tlPitbyPVkzpuzkxkPr
         u7EFNjKKxc1aLUVZhiRER+zUcP8zJ3Oofyid8KEfZ+YJhAnsDTjGNXolseMwuMbQuiQL
         nWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957210; x=1778562010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Y28fQgT8s+6wgnNieeWIuVixLHD6fzupoBYBwsX0f0=;
        b=JUqssKxMdYljAbalDg1LGbTzqme2CKVjru+wsK8Nh6r49zCkqapOli4YLoH/rnNeS2
         Bd0B9czPAhyS/PoSAuJqIyV+YbNZMcjJVNtqTC6euCCqDpaEaX76nZKluUfRH8aifL9f
         afFdNOlKKnTeHQcxYLTS6GpsfJuafr10IFJLwO/ute9LsJYBKspMCQIPi1nflNKF7C0D
         q4dIPsT/cdl4kQ+BdpG54FlVRZWO59SPyJ6XsSx+wiGZGchGSvTih2Xu35PieN6C4lsu
         eHuiZ8K7Uhxg6VpCct2pLr6hHxgwAay+BPHzmwTM9xJmNT+MoRXLwkzYZGxXZhRMWVPO
         Fv0w==
X-Forwarded-Encrypted: i=1; AFNElJ+gowxWK72qG5NB6PaPOj7MFv96Na5P8WkyqMN9sPSsonWt2OFBT2lK2zJslHG6IKqJTW0RYkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Rb/2T34qaaqEoUK2bAtnVP42k1DpxwU75pWDs9dyR6cnbcy0
	HycimQNG4K+D0MBH5XnR92y1H2/coyDb/IBEBz/58Oyfj4fwRKAzwC18
X-Gm-Gg: AeBDiet34GF3etOpFjQXpVbQsdhpzT/F3nIp1+rgCWKXzG529TQ/AymfSc5xcroWGpt
	vVzKhsPADOKHEag9CG7grmCVJ8Wep3zETa9K5XxCU2XXThjfn2JZjb+90pFMNDznC3dAUIlYHoN
	IRryV0V5eX4+8lq5yGA9Tk16GmjILFuygGNLxj8UaqoCCWqMaBpyHr+a2Q79vWB3uK77lQQXErw
	j6Qgouoz97ENXWkilISk9IMfFok91QGtY+UWDAc5gC/D7ct0o5+5DgH6nGcxNhOcacnTQxE/10e
	HVTjyKlWxc10ueAQXHvliAW3kYJP9j069qbeS6hJS9yQ6mSAcXN/aWw9OaaDhzUMC6t72BqDtlM
	b0Jp3sXewbZstmmoTHnlv8IJ6ulqY/GP+YOp75+1oQp6AajufmUeqN2K9MDGr67Mn1KMklktcs3
	+1gfeqU289Fh5Tc1oempNqKPLTq8kzIxKV04KwD783cqzDrYbMTtxumspbKtcv1On0J1G8fsU3l
	6bAde3B8rV+o0pCyNfHGAr6sg==
X-Received: by 2002:a05:7022:239e:b0:130:aa42:167b with SMTP id a92af1059eb24-130aa42171fmr1256387c88.36.1777957208284;
        Mon, 04 May 2026 22:00:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:06 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 07/20] Input: rmi4 - fix bit count in bitmap_copy()
Date: Mon,  4 May 2026 21:59:37 -0700
Message-ID: <20260505045952.1570713-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D60F74C6A3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243964-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

bitmap_copy() takes number of bits, not bytes (or longs). Correct
the bit count in rmi_driver_set_irq_bits() and
rmi_driver_clear_irq_bits().

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index c2843c21f0b9..ebff1ce07e58 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -388,9 +388,8 @@ static int rmi_driver_set_irq_bits(struct rmi_device *rmi_dev,
 							__func__);
 		goto error_unlock;
 	}
-	bitmap_copy(data->current_irq_mask, data->new_irq_mask,
-		    data->num_of_irq_regs);
 
+	bitmap_copy(data->current_irq_mask, data->new_irq_mask, data->irq_count);
 	bitmap_or(data->fn_irq_bits, data->fn_irq_bits, mask, data->irq_count);
 
 error_unlock:
@@ -419,8 +418,8 @@ static int rmi_driver_clear_irq_bits(struct rmi_device *rmi_dev,
 							__func__);
 		goto error_unlock;
 	}
-	bitmap_copy(data->current_irq_mask, data->new_irq_mask,
-		    data->num_of_irq_regs);
+
+	bitmap_copy(data->current_irq_mask, data->new_irq_mask, data->irq_count);
 
 error_unlock:
 	mutex_unlock(&data->irq_mutex);
-- 
2.54.0.545.g6539524ca2-goog


