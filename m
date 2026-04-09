Return-Path: <stable+bounces-235507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ih+GeEj2GmNYggAu9opvQ
	(envelope-from <stable+bounces-235507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 00:10:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9705B3D024B
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 00:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEFE03008626
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2DF3876D5;
	Thu,  9 Apr 2026 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="GhlvTmVE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA814332EAC
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772635; cv=pass; b=fbYSdzx9n1eIb6ahofJmX1jO7ZyUbrjZtIqaYs1m4l7+FBcI4FA4nxU+XMZlWWfALCzVUdcdbE5REB5E87P3m9zlGd/v/flGs0Mw1W5aUpjSTHq0o9+nfn7+p3itz8hDWbk9bLwowA6eg6ezv95P8WtJlubhmIfFW2H4xpMF7w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772635; c=relaxed/simple;
	bh=u6Edix2jXuIS8tFnaNTmah71uMoOsikDpNEPIIstLWo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A4HMonYCpLCr6wNCp/f2yPw1lDX55N7aPSNmxYZ0mirT5GVslKArXdrOLk3peY8J60mITQ6ZfGLuEOwMLZnsLEhATwJ3mLQtuAnO5TUuCIQc2b9ouIcRaP/RU6JpLqh3lfDXvxXmBW7phto6uwkAISFNzyeu4l+sctn2UeFl62I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=GhlvTmVE; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7982c3b7da9so13268497b3.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 15:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775772631; cv=none;
        d=google.com; s=arc-20240605;
        b=QYbVTT88o6neetCOQ0tBFZXFqrRmjBVgE2L1ydYNWqhglIOHl4JVPBqNFfr3YGbHuz
         pUwlI4Ec7nJFdMzfMwX6442CuIWv/pfuyRJA+r5QMLN0Xf5OlwNapwcGYzM7nd6CXGOt
         ZIdNvVW1K+WmQpp2f+aXRO83N7RGFXRZH9UCF6q4WoHmHQCaays176SAdAZMsC3txhoe
         h+m1c+vGZA87XclsK/ZY0M1OkUsIT0iTBvTu4U4pJtKiBuz6JjjCOxhaj0LGlE1FtltV
         z/5jycEdYmhoC87c+FejpMkgp+D+cqs3wImlCH4JdMVeSuMJEr0uosmra0BV333oDMe+
         yhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9OYRv8rvi0/sGy/tiETryCkJVCR2waOffWO1EsBR59E=;
        fh=0WCLU96Gg+USV+k1Eso1M7p7T/nd0KkM7cTpm+KoY00=;
        b=MrxoQzmeQj643x6zUwZOsVoM88SGgvlwAJLmFdY0LosMvYm1oot3/xwZk6VUDqVmoS
         5I7gt8aUja/il/yzGBkcdcn1g8k8L9831TYJvvewJ/NTFP1DgYJfR0cCzHSMqMR2afuj
         h4LeoAtTdiyXpfr/Bx7+xiB8mfqPCJETRLly4+WiA5hFtazu81mFt+9Addl+HMySMbtA
         QWhNhjXm5QTvFOLr20gwgtFINtImwwGHbeY3mg5pI2FaY3VnYJn6DZXz4KHNAlRz0/PF
         2jsYECJto7yL8VWx/5Sr9RprotnbtMj5qba4BkKRVpdQNm+/tbezTrK81vSwbpLPLUUr
         L9Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775772631; x=1776377431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OYRv8rvi0/sGy/tiETryCkJVCR2waOffWO1EsBR59E=;
        b=GhlvTmVEAj2WRkDBStv/w89BVOlPRS7k9cp/nP6BchnwC+XdsxXNqRfK8p8EkUh7J1
         /GOjuhAxzcJmlcfG7WGBoCKuQuTDv79AY+QVD0QhuWwd4bywHPdZzgBFK3WFf7yGaHzI
         WpBcR6HhVO+s1JzyP/SDPygBfmNAcZvhI1M8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772631; x=1776377431;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OYRv8rvi0/sGy/tiETryCkJVCR2waOffWO1EsBR59E=;
        b=aWMADoXBccZ8Wv61N2a+l/RITHQmKKwyd3hp3NpwGVRB1ASzfr7A2VRmdHMOt/OO1G
         5GKco92aN0yfQvm17Dz5+H/nUwjy+lfeesYWVgbYEW71CqzmgOlVqP1updUyBxs3R4G/
         GEEf5LFEu4M8YkdiVepogdHa37ahTNQTjfXgzyEo+VYWgxFa0Ly08Br5xqvDixD6A+DG
         HqE/cwLuJJsYIaXb5d36dl0VO9jn9f5Xozcu2D4Van9Z769tUJFXAuStbeQ+t+2MruS9
         LoRk2BGzAtqL1+idZPGGMrVEXYtpS7c89MHKNgKFfxDwN6x3oOpt13r/Cv0sbF6TSF8B
         GkVw==
X-Forwarded-Encrypted: i=1; AJvYcCV93UplDSaPdHjHZWeJY4hATR4bmv8VuHn+MGMht7Rr45+jUMlsZBzozkkKO6SekORWHhpEDqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHq1742ri/qSyUQcDy2jpUL6uAs2Q3ziWSPbKb52uCmx93Kxjh
	vwr18Cx2lmftd0R0VrES+DaWpCHsWHLO4YTzbBgoertD52HtEdtzDGFThsn32MKCdD4oUni/qTz
	SX5RnsIpN9YoJ22PLZNTVUBzDAKvL9spyFoB8rQOJ/g==
X-Gm-Gg: AeBDievZQHfv9pKkMiYBuPAa7/lmioNFOdm/QleR1nL5/KPtWxxv3S0Npd9Q9EbTyx1
	5htAI5mXO98nJ31EdzOQKH0EOj7b5yXaFGWeTiHJlPiCLK8b7EQiUAp/CeecqFz3tH1Lxw2Sovw
	SoWtOAzhNrEy+E5TabDz6NmRljuq6oyQWP+VKrVMsSdtVzvQLpxFbd6n39WcBkuT1XKFkJI9aMn
	YWnnDPHCJHsKvO65IHoOrFU4fk8OuBqQHf4idEgmQvRAl8J6uSb9NgZMwBGVbxAyCFKI8TeKPiq
	uxWms+PHB06T2NuaErvVSsSG1mnutNjVs1Uojmqj4DbA4UCT+oW6YwIysGFEFO6kdhozYubKHaW
	ZKtnjgMmFmcZ8Fk4q3/2JyLhZixGzJ6V4iEWLCcfSzZJ4YD/lkp614merRz+bMoo=
X-Received: by 2002:a05:690c:101:b0:79a:d067:1b4c with SMTP id
 00721157ae682-7af6f22b14emr7813727b3.7.1775772631395; Thu, 09 Apr 2026
 15:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sina Hassani <sina@openai.com>
Date: Thu, 9 Apr 2026 15:10:20 -0700
X-Gm-Features: AQROBzCM67wdyRTF025m1tdh9-7YRagOsrTvvnfPYDG5A2v0aHgobJFekGQYxnM
Message-ID: <CAAJpGJQ4VyeaZyVwh0Y-tanUCAqiY8v=rmiGr8cp_XmFph=SGQ@mail.gmail.com>
Subject: [PATCH v3] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235507-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openai.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sina@openai.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9705B3D024B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the loop
body when getting to the more expensive unmap operations. This is fine on
its own except the loop condition is based on the first area that matches
the unmap address range. If a concurrent call to map picks an area that was
unmapped in the previous iterations, this loop will try to mistakenly unmap
them.

How to reproduce: I was able to reproduce this by having one userspace
thread mapping buffers and passing them to another thread that unmaps
them. The problem easily shows up as ebusy errors if you use single page
mappings.

The fix: A simple fix that I implemented here is to advance the start
pointer after we unmap an area. That way we are only looking at the
IOVA range that is mapped and hence guaranteed to not have any overlaps
in each iteration.

Test: I tested this against the repro mentioned above and it works fine.

Cc: stable@vger.kernel.org
Signed-off-by: Sina Hassani <sina@openai.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c
b/drivers/iommu/iommufd/io_pagetable.c
index ee003bb2f647..e306871de06d 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -814,6 +814,14 @@ static int iopt_unmap_iova_range(struct
io_pagetable *iopt, unsigned long start,
                unmapped_bytes += area_last - area_first + 1;

                down_write(&iopt->iova_rwsem);
+
+               /* Do not reconsider things already unmapped in case of
+                * concurrent allocation */
+               if (area_last >= last) {
+                       break;
+               } else {
+                       start = area_last + 1;
+               }
        }

 out_unlock_iova:
--
2.43.0

