Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C200E73DA31
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjFZIrt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 04:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFZIrt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 04:47:49 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA8293
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 01:47:48 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-c1061f0c282so2377126276.1
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 01:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687769267; x=1690361267;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3twiG2p9jLxhq2ZKBnDZt1a9AL4gy9GmDW9VqOR4ARo=;
        b=AXD17QqgweTjN0/HQqp5Fq73cqqW09JBmU0h0nqEgRmCk4vAwgpXuH61RQ7b8BqMQI
         T2gMXwJuhupq+mTkaOl3qcOek6hf1Rzry5LH/6o/M16j0bv8ALh2PeaTQNgjEwGdyChA
         Q6l23aNeWfHA1V5sKbN68yXve+i2zwjgX+OdOghVR7ijA2uTwufnP2G6iRR8IfSX8LcI
         JwQRTmGBOCwJph7yoyg1IfG4PZk+wX6VDbWS/N5SR3aWOlbVBKu7Hhz9YCZ3x+w4hnU6
         PN4HU4V8UHJTvRuVlH+r8nLcB9PiCY4zaQ1HljcdNmZi6EmRRPjbWzFzw9Wjz2uLDomv
         TTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687769267; x=1690361267;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3twiG2p9jLxhq2ZKBnDZt1a9AL4gy9GmDW9VqOR4ARo=;
        b=HI5u2wjPSAhhCCElYrySEQOAtsxDkUlL0SEehiLAW+lshwT26fxq8/mj8huw1HbY4c
         dKEeNTJEx8XDRUmsSjAqbf5fqtEQlzF7kzepIzgE2IBYiF0J0j2sRjMx2GqV0/aY1OZG
         3DYJUKVE5DsQZXvgeM9WY9yJyFlL5THHLjS9ioUdOyTNTDQlt3X13w06HscioMNbURlS
         LKudBACL4tgmI4UuBHm7oReH4guybn7Pbt+bTmPP/W6XIZKPuXSzdkGesVwaRK0N2jKe
         fqXA0fAAGbNtXDZd48XTTXwxQWEOZUb6jxYKZtlycKTYIcJjQklG1SXvuAfpgukHYWHj
         KkpQ==
X-Gm-Message-State: AC+VfDxO43xMM4CjQQ1VBYKQ3RgYzRvQUrHuwpxHl8rWm4bXXhdhBu9K
        QFRifisUYfGmEJGRvDuAXV7vnQy6oVweZQlGh3I=
X-Google-Smtp-Source: ACHHUZ6iTGHOGgIIfRFoSsOUU7uUXpXUGU2MnXKHwYIWUcJ/3tQpRMiKsH8ow7+79fO6D/6UcGjNumyCi1bOfcyLYd4=
X-Received: by 2002:a25:80d4:0:b0:c02:e455:e2c0 with SMTP id
 c20-20020a2580d4000000b00c02e455e2c0mr9784135ybm.11.1687769267548; Mon, 26
 Jun 2023 01:47:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:9381:b0:4e1:c1e7:9a3c with HTTP; Mon, 26 Jun 2023
 01:47:47 -0700 (PDT)
Reply-To: helenwilson142@gmail.com
From:   Helen Wilson <dlisa1780@gmail.com>
Date:   Mon, 26 Jun 2023 08:47:47 +0000
Message-ID: <CAHGCEsv=dpEMZWn+e__z=DWCJ-BgAQqCAPiuQ4xKZM_H63Nckw@mail.gmail.com>
Subject: 
To:     helenwilson142@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hey
