Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D381C7E1256
	for <lists+stable@lfdr.de>; Sun,  5 Nov 2023 06:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjKEFwA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 5 Nov 2023 01:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEFwA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 5 Nov 2023 01:52:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70BE125
        for <stable@vger.kernel.org>; Sat,  4 Nov 2023 22:51:56 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso3635052276.2
        for <stable@vger.kernel.org>; Sat, 04 Nov 2023 22:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699163516; x=1699768316; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=eeo6WR/P4l46+KS9HNgrgl6iAS5vgODmp+bZR7zcr17GUxi2D33VComnn9KqyZFEmv
         SJ6TgY0lvju+yLkIpOdo20tk+8HmuXwUreW+gxrlZEl8JtVlEKEoyfygLiOjYPRpdfDx
         532mPHDNR1mrFunsC0qvL+0MJdjJTijy5KRkiE2kG5V0CISaksZZYzBCoUZ356GDWv1+
         JOz7qAEAjAWDOcv/O7JIAB205ZRTkIpZSuOC0UxshGrnjfBaaDv0+gQ0jDxy1xZCbJi+
         J0WA8bRk9hGxB2bLKCJ+6vNw2nztMT8fPAb8sblrgUXFyaT+M9CBBsO2+4PFZ6Oyblap
         NDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699163516; x=1699768316;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=l7Ch0TAGMKC05UNiVcx1cnvx8iSb21MoI87S71nV71DJ0xGQ0OUORgwx7G0F+0ays5
         QvRHr2PvlSUCu5L1L0hIXYiNhjQ9Np6xv6v+az/lSpbKEMO2S8O/6aUdf7qbzzZQNDPd
         dFVJ7W32oSxgnAu3jsjNqO3GRhhboFVw5N1yXv+1zQO88LdElFYhpxFaiB5PkrGuQbnf
         +WBFV+4tyrinTzvp5KBG+3fr8aNcqKLXqqEgxGJbPLnVVxXVEiUULg8LDTwn+ff3SCou
         Wl6CAGioTZJECdPgQaqO9UVdWHHtnY9RXWCGC4u2brgIHc01oX3rlnnGBZbLTPtPkmK9
         VfWA==
X-Gm-Message-State: AOJu0YwdX+n9xBu+yOmzXHXLJR/JJgOz8Qf/I6SoxMmT7cLO8QM3oT1X
        4oUvRmXVXFJFRL0gM1queTqu2Bs9QAyt3AtoDuc=
X-Google-Smtp-Source: AGHT+IE0R3OyzG2a75h7I3T221889hosoVCDnzF3sVwqNqiYwifAgaerfqxdZ+lv573E0EHnIRyCTdzLQdrKOFi8/88=
X-Received: by 2002:a25:2649:0:b0:da0:cb1f:286c with SMTP id
 m70-20020a252649000000b00da0cb1f286cmr23630455ybm.41.1699163515802; Sat, 04
 Nov 2023 22:51:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7011:a1d3:b0:385:f394:9b with HTTP; Sat, 4 Nov 2023
 22:51:55 -0700 (PDT)
Reply-To: dorismartins9000@gmail.com
From:   Doris Martins <lorfordlandrew02@gmail.com>
Date:   Sat, 4 Nov 2023 22:51:55 -0700
Message-ID: <CAHMCJfY1EsXigYDubDy-QrEmOpdy9eT9WEASfEX1coj2RKkU3A@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,
