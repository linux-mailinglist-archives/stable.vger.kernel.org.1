Return-Path: <stable+bounces-196960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55383C88413
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDBDC4E25FD
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 06:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D8C284B29;
	Wed, 26 Nov 2025 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRUSwL+z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A69625
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138194; cv=none; b=Fyb28cuCFv12qanTFCPUOZpeEKUZtfLF2SZLbgAemSPZBG5jcqzfOEo+omUZ9HT0CJNFc7Yhn1fWy6zH6+4XvlvmHGrg4GEyF0s+ZcV3KFu2XJ3D7ax/T6L9ZwYRAZ3oAmbYXycrbXb9IzyWrQ+a0N0X/7gO2UbyvgRSYwrK8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138194; c=relaxed/simple;
	bh=Q0pXdmyLv/HFl/v2RyEMPzZYl67ksLmMNqJ6/2sIDus=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jzJG6Z2POMjamvrJO/OIBsLESy0cTFACNfCBOJVwi6lYXFxJwv69KB4T5IPovZKeYaF/+FUUec18ww6B4rsILFkCGAhsG10AGJga33eAhzdp5bg6K++c/8+DkuUcRUeRik+kLwUE0A/osEzA7zGRgMs3HcVGYOwmGofcZXNhA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRUSwL+z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a998ab7f87so10338577b3a.3
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 22:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764138192; x=1764742992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xZOiqnOu5b455b+cb+x4p1lTrQe4haMsZgH0ji8uoDo=;
        b=vRUSwL+zroirVOHHZ8motxnGZj6U84PAMzURLYtetUw60CoB/xUbPoW+rd50MJz8Of
         20EDq5Vq54esgBODnnE0DjFzdeehtaCRzbXq22q8Uj0nlj+kPo8um24a79dR6kfdzBjJ
         8liR9hs8pFMjXLucVj0EF67zH+PFYaY8nw5LoCL46SabsukhaR0Ej2mtop02nLCD/sFF
         vjsiZjG7fEFQhop6tvxqSfMcN/RiaqIyDmtMJEndfSEhil4wXRVh1faLKbCrk3kukL20
         Dj0ncRQRwHwV1b5Lj7pBpgTSrVajvNjq4UUbWq65BazSEk8Mymu0d8D8npniW2Uv3XJg
         SRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138192; x=1764742992;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZOiqnOu5b455b+cb+x4p1lTrQe4haMsZgH0ji8uoDo=;
        b=ttrTq52y0wCCo4t/XAdcaJbyYoJQ00jJyfEKtBgFWjlit0r+XcUhInb/6aJJvf91yq
         BqTnXbxqNkS69OxWan/fqnqiETvSsTK542XyxNUB/+FrdDQ1TKk3CMmwx5zDAyvPwhdm
         sGMfDR7+Riw/I0cUTvl6CNJKpPBlACI79RxPG+PDmVOmD4SbzgiOng/rEQBTBI2IjPUy
         GP3tFkqszrKGMFecc76epv1YOby8f6EzvcV4Av6zZaejbELE91jLn6KZNkL58OQdtYTo
         YwLNuKvYOKhazCF5KTPvIMIXwhu/YQoOhJ3gS7Rwr1XuSRG+ZBvbRKBYd9apaaOMIp4+
         VPlw==
X-Forwarded-Encrypted: i=1; AJvYcCU2hbG+nkNFGh7Z47zVG6ZYUClpDPb/eoOGix0gO2mGjBiVSYFzVla2oNDv9yg+NNDOB/XEIFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykw3QEfrRtwQbpZJJsQ7cCFD2Tyyjvr6z1uKyRtCaDhttGf5hZ
	jMCf/SaTff0deIxAfpoqdekwLPkX86wAfC8SavT2QppvRuRKaoyAEYX+ZDp32DkxSR5kQz6k9Uo
	za1qPN2T9RqqXFNz1aTAqeeclNA==
X-Google-Smtp-Source: AGHT+IH9vjRZL8U+Jv8MQaygGYF05+chijEWXrtWm9JsC760HiVPZONCUU0e9FG6cb8eV19VffM49vujA7k5WB70zw==
X-Received: from pfbfh7.prod.google.com ([2002:a05:6a00:3907:b0:7b0:bc2e:9592])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88d1:0:b0:7a2:84df:23dc with SMTP id d2e1a72fcca58-7c58e604ffbmr19619687b3a.28.1764138191863;
 Tue, 25 Nov 2025 22:23:11 -0800 (PST)
Date: Wed, 26 Nov 2025 06:22:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126062250.2566655-1-joonwonkang@google.com>
Subject: [PATCH v4] mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com, broonie@kernel.org
Cc: peng.fan@oss.nxp.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org, Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"

Although it is guided that `#mbox-cells` must be at least 1, there are
many instances of `#mbox-cells = <0>;` in the device tree. If that is
the case and the corresponding mailbox controller does not provide
`fw_xlate` and of_xlate` function pointers, `fw_mbox_index_xlate()` will
be used by default and out-of-bounds accesses could occur due to lack of
bounds check in that function.

Cc: stable@vger.kernel.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
V3 -> V4: Prevented access to sp->args[0] if sp->nargs < 1 and rebased
          on the linux-next tree.

For CVE review, below is a problematic control flow when
`#mbox-cells = <0>;`:

```
static struct mbox_chan *
fw_mbox_index_xlate(struct mbox_controller *mbox,
                    const struct fwnode_reference_args *sp)
{
    int ind = sp->args[0];                                      // (4)

    if (ind >= mbox->num_chans)                                 // (5)
        return ERR_PTR(-EINVAL);

    return &mbox->chans[ind];                                   // (6)
}

struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
{
    ...
    struct fwnode_reference_args fwspec;                        // (1)
    ...
    ret = fwnode_property_get_reference_args(fwnode, "mboxes",  // (2)
                                             "#mbox-cells", 0, index, &fwspec);
    ...
    scoped_guard(mutex, &con_mutex) {
        ...
        list_for_each_entry(mbox, &mbox_cons, node) {
            if (device_match_fwnode(mbox->dev, fwspec.fwnode)) {
                if (mbox->fw_xlate) {
                    chan = mbox->fw_xlate(mbox, &fwspec);       // (3)
                    if (!IS_ERR(chan))
                        break;
                }
		...
            }
        }
        ...
        ret = __mbox_bind_client(chan, cl);                     // (7)
        ...
    }
    ...
}

static int __mbox_bind_client(struct mbox_chan *chan,
                              struct mbox_client *cl)
{
    if (chan->cl || ...) {                                      // (8)
}
```

(1) `fwspec.args[]` is filled with arbitrary leftover values in the stack.
    Let's say that `fwspec.args[0] == 0xffffffff`.
(2) Since `#mbox-cells = <0>;`, `fwspec.nargs` is assigned 0 and
    `fwspec.args[]` are untouched.
(3) Since the controller has not provided `fw_xlate` and `of_xlate`,
    `fw_mbox_index_xlate()` is used instead.
(4) `idx` is assigned -1 due to the value of `fwspec.args[0]`.
(5) Since `mbox->num_chans >= 0` and `idx == -1`, this condition does
    not filter out this case.
(6) Out-of-bounds address is returned. Depending on what was left in
    `fwspec.args[0]`, it could be an arbitrary(but confined to a specific
    range) address.
(7) A function is called with the out-of-bounds address in `chan`.
(8) The out-of-bounds address is accessed.

 drivers/mailbox/mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 2acc6ec229a4..617ba505691d 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -489,12 +489,10 @@ EXPORT_SYMBOL_GPL(mbox_free_channel);
 static struct mbox_chan *fw_mbox_index_xlate(struct mbox_controller *mbox,
 					     const struct fwnode_reference_args *sp)
 {
-	int ind = sp->args[0];
-
-	if (ind >= mbox->num_chans)
+	if (sp->nargs < 1 || sp->args[0] >= mbox->num_chans)
 		return ERR_PTR(-EINVAL);
 
-	return &mbox->chans[ind];
+	return &mbox->chans[sp->args[0]];
 }
 
 /**
-- 
2.52.0.487.g5c8c507ade-goog


