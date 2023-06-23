Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E373BB47
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjFWPMk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFWPLa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 11:11:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4254B30D8
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 08:11:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561eb6c66f6so10751017b3.0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533055; x=1690125055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6FSiQisg0W7MOfyBIAiPdkeELt112zv/p4uKtG83Y0=;
        b=uLzCMJTw7jDxS6vNull8bIpFUWN/rBWTBCpL4cvA+4bgV96XBXkEvusTIVrUSsTbE/
         6QZb64qW2UIzBrT10hhQbkhpCO0MdVvuJn1UIUklgJYZOBpX/RRgP6cvbZsti/Q0pV9T
         lSuGOa6+dLJZq8Ih5W7yX+a26+/n+Js77Cgrr7TOaKfktmdBkQvKGRlLRgCd+RIMsXpa
         bwHrHYdfMMbHhZ3EODuiAbpfX4gW8gJ5w3+4JlNPz7dCwySWpxcB1P3sM0Dp1y1oJ4Ib
         UsCx9khVhwwPqXsEHrsaRx385tz6R5Vr1rc1mKdoaDeXckjssRzo4gi88skKkFdc6hFG
         N/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533055; x=1690125055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6FSiQisg0W7MOfyBIAiPdkeELt112zv/p4uKtG83Y0=;
        b=DK/UoudznHtWH3rPDTq966qNs6n7tsXlq99xcnCEWsm67ERai6efiqmyuwXwvjyRDd
         ytOVqXO1GzDNr0/k/c1h6lbl8vbV8Y4ZjlXYaEoW9wbap1v/n5vfCNcUbIjSWa/0uAOb
         2I5OkGJ2Fe+2UuPDhkoJGc4RHVzNomQNx2VRg7hUsQAIW3wYGKd8GrIel3ODiKO8o00i
         oVmWwzwo0Avhot3ZPBADh9Fj2n2B4pT15wzxKs2sUtUyqRvez+qCkbUPbIBaCvIeDGND
         10b4mFjLTEtX82YI1WZrFnjRw3l5yUHT3NuGKamhyytPbGhCFGGiVY1P70Ai4gW66ExC
         U/Fg==
X-Gm-Message-State: AC+VfDyU4ZTxS0WdvkqkBMUIzdhPPIq5ooO4rrBi2aNp5CY3YhOJZDYF
        2CvimSFZ3PbA6dY75y0p2eLfcH2fpSF/
X-Google-Smtp-Source: ACHHUZ5Hc+kLLEtZILQ4Wma4p08PO6/FbwCQ/44hQJQvk3dSaS/TSPaISlSEc+0hqXQbINbYXQj+bHrZ0eR3
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:5d47:84a:2819:bba4])
 (user=kyletso job=sendgmr) by 2002:a81:af11:0:b0:573:87b9:7ee9 with SMTP id
 n17-20020a81af11000000b0057387b97ee9mr5097095ywh.4.1687533055500; Fri, 23 Jun
 2023 08:10:55 -0700 (PDT)
Date:   Fri, 23 Jun 2023 23:10:36 +0800
In-Reply-To: <20230623151036.3955013-1-kyletso@google.com>
Mime-Version: 1.0
References: <20230623151036.3955013-1-kyletso@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230623151036.3955013-4-kyletso@google.com>
Subject: [PATCH v2 3/3] usb: typec: Use sysfs_emit_at when concatenating the string
From:   Kyle Tso <kyletso@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The buffer address used in sysfs_emit should be aligned to PAGE_SIZE.
Use sysfs_emit_at instead to offset the buffer.

Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
---
Update v2:
- Add "Cc: stable@vger.kernel.org"

drivers/usb/typec/class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index e7312295f8c9..9c1dbf3c00e0 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1288,9 +1288,9 @@ static ssize_t select_usb_power_delivery_show(struct device *dev,
 
 	for (i = 0; pds[i]; i++) {
 		if (pds[i] == port->pd)
-			ret += sysfs_emit(buf + ret, "[%s] ", dev_name(&pds[i]->dev));
+			ret += sysfs_emit_at(buf, ret, "[%s] ", dev_name(&pds[i]->dev));
 		else
-			ret += sysfs_emit(buf + ret, "%s ", dev_name(&pds[i]->dev));
+			ret += sysfs_emit_at(buf, ret, "%s ", dev_name(&pds[i]->dev));
 	}
 
 	buf[ret - 1] = '\n';
-- 
2.41.0.162.gfafddb0af9-goog

